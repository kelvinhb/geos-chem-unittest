#------------------------------------------------------------------------------
#                  GEOS-Chem Global Chemical Transport Model                  !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: gchp.ifort15_mvapich2_standalone.bashrc
#
# !DESCRIPTION: Use this .bashrc to compile and run GCHP with the Intel 
#  Fortran Compiler v15 and MPI implementation MVAPICH2 on a standalone 
#  Linux server.
#\\
#\\
# !CALLING SEQUENCE:
#  source gchp.ifort15_mvapich2_standalone.bashrc  or
#  . gchp.ifort15_mvapich2_standalone.bashrc
#
# !REMARKS
#  This assumes a configuration where all required libraries (listed below)
#  are installed in the current directory with the standard lib, include, bin
#  directories.
#  
#  Dependencies & Tested Versions, installed in this exact order:
#    - Intel C/Fortran Compiler, 2015.6
#    - mvapich2, 2.3b
#    - zlib, 1.2.11
#    - HDF5, 1.8.20
#    - NetCDF-C, 4.4.1.1
#    - NetCDF-Fortran, 4.4.4
#  Take special care to use the MPI compilers (mpicc, mpicxx, mpifort) to
#  compile the dependency libraries, and enable parallel HDF5. 
#
# !REVISION HISTORY:
#  01 Feb 2018 - HP. Lin - Initial version based on the Odyssey variant by 
#                          S. Eastham and GEOS-Chem contributors.
#  05 Mar 2018 - E. Lundgren - Minor modifications for clarity
#  See git commit history for subsequent revisions
#EOP
#------------------------------------------------------------------------------
#BOC

#==============================================================================
# Aliases (edit/add/remove based on your system and preferences)
#==============================================================================

# Clean run directory before a new run
# WARNING: will delete gchp.log and contents of OutputDir
alias mco="make cleanup_output"       

# Recompile GC but not MAPL, ESMF, dycore
alias mcs="make compile_standard"     

# Run GCHP (Edit as needed for # of cores; you may replace w/ job script submit)
alias gchprun="mpirun -np 64 ./geos | tee gchp.log"

# Follow log output on screen
alias tfl="tail --follow gchp.log -n 100"   

# Show current code git info
alias checkgit="make printbuildinfo"        

# Show build code git info
alias checkbuild="cat lastbuild"            

#==============================================================================
# Environment variables
#==============================================================================

export LD_LIBRARY_PATH="$(dirname $(dirname $(which mpirun)))/lib"

# Depending on your compiler configuration, and the library you are buliding,
# you may or may not need the below lines.
# export LDFLAGS="-L$(dirname $(dirname $(which mpirun)))/lib"
# export CPPFLAGS="-I$(dirname $(dirname $(which mpirun)))/include"

# EDIT THE BELOW LINE to set up compiler variables for the Intel compiler.
# source /home/hplin/common/compilers/intel/15/composer_xe_2015.6.233/bin/compilervars.sh intel64

# Specify compilers.
export CC=icc
export CXX=icpc
export FC=ifort
export OMPI_FC=ifort
export OMPI_CC=icc
export OMPI_CXX=icpc
export COMPILER=ifort
export ESMF_COMPILER=intel

# For ESMF compilation ONLY!
# Disable these when compiling mvapich2 & netcdf, or configure will not allow 
# you to proceed.
export F77=$FC
export F90=$FC

# MPI Communication
export ESMF_COMM=mvapich2
export MPI_ROOT=$( dirname $( dirname $( which mpirun ) ) )
export OMP_NUM_THREADS=0
export MV2_SMP_USE_CMA=0

# Base Paths - Edit as necessary. Assumed standard configuration.
export GC_BIN="$(dirname $(dirname $(which mpirun)))/bin"
export GC_INCLUDE="$(dirname $(dirname $(which mpirun)))/include"
export GC_LIB="$(dirname $(dirname $(which mpirun)))/lib"

export HDF5DIR="$(dirname $(dirname $(which mpirun)))"

# If using NetCDF after the C/Fortran split, you will need to specify the 
# following environmental variables.
export NETCDF_FORTRAN_HOME="$(dirname $(dirname $(which mpirun)))"
export NETCDF_FORTRAN_INCLUDE="$(dirname $(dirname $(which mpirun)))/include"
export NETCDF_FORTRAN_LIB="$(dirname $(dirname $(which mpirun)))/lib"

export GC_F_BIN="$NETCDF_FORTRAN_HOME/bin"
export GC_F_INCLUDE="$NETCDF_FORTRAN_INCLUDE"
export GC_F_LIB="$NETCDF_FORTRAN_LIB"

# Set ESMF optimization (g=debugging, O=optimized (capital o))
export ESMF_BOPT=O

#==============================================================================
# Raise memory limits.
#==============================================================================

ulimit -c unlimited              # coredumplimit
ulimit -l unlimited              # memorylocked
ulimit -u unlimited              # maxproc
ulimit -v unlimited              # vmemoryuse

#==============================================================================
# Print information for clarity
#==============================================================================

echo "Environment variables set:"
echo ""
echo "LD_LIBRARY_PATH: ${LD_LIBRARY_PATH}"
echo ""
echo "ESMF_COMM: ${ESMF_COMM}"
echo "ESMP_BOPT: ${ESMF_BOPT}"
echo "MPI_ROOT: ${MPI_ROOT}"
echo "MVAPICH2: ${MVAPICH2}"
echo "MV2_USE_THREAD_WARNING: ${MV2_USE_THREAD_WARNING}"
echo "MV2_ENABLE_AFFINITY: ${MV2_ENABLE_AFFINITY}"
echo "MV2_USE_SHARED_MEM: ${MV2_USE_SHARED_MEM}"
echo "MV2_SMP_USE_CMA: ${}"
echo ""
echo "LDFLAGS: ${LDFLAGS}"
echo "CPPFLAGS: ${CPPFLAGS}"
echo "HDF5DIR: ${HDF5DIR}"
echo ""
echo "CC: ${CC}"
echo "OMPI_CC: ${OMPI_CC}"
echo ""
echo "CXX: ${CXX}"
echo "OMPI_CXX: ${OMPI_CXX}"
echo ""
echo "FC: ${FC}"
echo "F77: ${F77}"
echo "F90: ${F90}"
echo "OMPI_FC: ${OMPI_FC}"
echo "COMPILER: ${COMPILER}"
echo "ESMF_COMPILER: ${ESMF_COMPILER}"
echo ""
echo "GC_BIN: ${GC_BIN}"
echo "GC_INCLUDE: ${GC_INCLUDE}"
echo "GC_LIB: ${GC_LIB}"
echo ""
echo "NETCDF_FORTRAN_HOME: ${NETCDF_FORTRAN_HOME}"
echo "NETCDF_FORTRAN_INCLUDE: ${NETCDF_FORTRAN_INCLUDE}"
echo "NETCDF_FORTRAN_LIB: ${NETCDF_FORTRAN_LIB}"
echo ""
echo "GC_F_BIN: ${GC_F_BIN}"
echo "GC_F_INCLUDE: ${GC_F_INCLUDE}"
echo "GC_F_LIB: ${GC_F_LIB}"
echo ""
echo "Done sourcing ${BASH_SOURCE[0]}"