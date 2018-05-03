#------------------------------------------------------------------------------
#                  GEOS-Chem Global Chemical Transport Model                  !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: gchp.ifort15_openmpi_odyssey.bashrc
#
# !DESCRIPTION: Source this bash file to compile and run GCHP with the
#  Intel Fortran Compiler v15 and MPI implementation OpenMPI on the 
#  Harvard University Odyssey cluster. Compare it to the ifort15_mvapich2
#  bash file to see the differences when changing MPI.
#\\
#\\
# !CALLING SEQUENCE:
#  source gchp.ifort15_openmpi_odyssey.bashrc  or
#  . gchp.ifort15_openmpi_odyssey.bashrc
#
# !REMARKS
#
# !REVISION HISTORY:
#  26 Oct 2016 - S. Eastham  - Initial version
#  03 Feb 2017 - S. Eastham  - Updated for GCHP v1
#  05 Jan 2018 - E. Lundgren - Initial commit
#  See git commit history for subsequent revisions
#EOP
#------------------------------------------------------------------------------
#BOC

if [[ $- = *i* ]] ; then
  echo "Loading modules for GCHP on Odyssey, please wait ..."
fi

#==============================================================================
# Aliases (edit as needed for your preferences)
#==============================================================================

# Submit a run as a batch job
alias gchprun="sbatch gchp.run"

# Recompile GC but not MAPL, ESMF, dycore
alias mcs="make compile_standard"     

# Clean run directory before a new run
alias mco="make cleanup_output"       

# Follow log output on screen
alias tfl="tail --follow gchp.log -n 100"   

# Show current code git info
alias checkgit="make printbuildinfo"        

# Show build code git info
alias checkbuild="cat lastbuild" 

#==============================================================================
# Modules (specific to compute cluster)
#==============================================================================

# These modules were defined with the older "module" command but are in the
# process of being renamed during the transition to "lmod".  We still need
# these for the GIGC/ESMF/MPI environment, so load them by their old names.
source new-modules.sh

module purge
module load git

module load intel/15.0.0-fasrc01
module load openmpi/1.10.3-fasrc01
module load zlib/1.2.8-fasrc03
module load hdf5/1.8.12-fasrc12
module load netcdf/4.1.3-fasrc09

#==============================================================================
# Environment variables
#==============================================================================

# Specify compilers
export CC=gcc
export OMPI_CC=$CC

export CXX=g++
export OMPI_CXX=$CXX

export FC=ifort
export F77=$FC
export F90=$FC
export OMPI_FC=$FC
export COMPILER=$FC
export ESMF_COMPILER=intel

# MPI Communication
export ESMF_COMM=openmpi
export MPI_ROOT=$( dirname $( dirname $( which mpirun ) ) )

# Base paths
export GC_BIN="$NETCDF_HOME/bin"
export GC_INCLUDE="$NETCDF_HOME/include"
export GC_LIB="$NETCDF_HOME/lib"

# Add to primary path
export PATH=${NETCDF_HOME}/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${NETCDF_HOME}/lib

# Set ESMF optimization (g=debugging, O=optimized (capital o))
export ESMF_BOPT=O

#==============================================================================
# Raise memory limits
#==============================================================================

ulimit -c unlimited              # coredumpsize
ulimit -l unlimited              # memorylocked
ulimit -u unlimited              # maxproc
ulimit -v unlimited              # vmemoryuse

#==============================================================================
# Print information for clarity
#==============================================================================

echo "Modules loaded:"
module list
echo ""
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
echo "Done sourcing ${BASH_SOURCE[0]}"