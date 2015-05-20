#------------------------------------------------------------------------------
#                  Harvard-NASA Emissions Component (HEMCO)                   !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: HEMCO_Config.rc
#
# !DESCRIPTION: Contains configuration information for HEMCO. Define the
#  emissions inventories and corresponding file paths here. Entire 
#  configuration files can be inserted into this configuration file with
#  an '>>>include' statement, e.g. '>>>include HEMCO\_Config\_test.rc' 
#  The settings of include-files will be ignored.
#\\
#\\
# !REMARKS:
#  The following tokens will be replaced:
#  (1) ROOT    : Filepath to HEMCO root directory
#  (2) CFDIR   : Filepath to directory of this configuration file. 
#  (3) MET     : Met field type (from G-C compilation command)
#  (4) GRID    : Horizontal grid type (from G-C compilation command)
#  (5) SIM     : Simulation type (from G-C compilation command)
#  (6) NEST    : Nested-grid type (CH, EU, NA, SE)
#  (7) LNOX    : String for OTD/LIS lightning NOx files:
#                (a) For GEOS-5 this is either "geos5.1.0" or "geos5.2.0".  
#                (b) For other met fields, this is the same as MET.
#  (8) LEVRED  : String w/ the # of levels in the reduced GEOS-Chem grid
#                as used in some filenames (e.g. "23L", "30L", "47L")
#  (9) LEVFULL : String w/ the # of levels in the full GEOS-Chem grid
#                as used in some filenames (e.g. "55L", "72L")
# 
# !REMARKS:
#  Customized for the nested China/SE Asia simulation
#  (regional emissions over Europe, Canada, USA, and Mexico are turned off)
#
# !REVISION HISTORY: 
#  17 Apr 2014 - R. Yantosca - Initial version
#  02 Jul 2014 - R. Yantosca - Now use a 1 x 1 file for DMS seawater
#  02 Jul 2014 - R. Yantosca - Now added LNOX token
#  28 Jul 2014 - R. Yantosca - Now added "Unit tolerance" setting
#  12 Aug 2014 - R. Yantosca - Now added FINN files
#  18 Aug 2014 - R. Yantosca - Use proper NO2 to NO conversion for AEIC
#  18 Aug 2014 - R. Yantosca - Don't use diurnal factors for biofuel C2H6 
#  29 Aug 2014 - R. Yantosca - Apply GEIA_TOD_FOSSIL scale factor to NEI2005
#  04 Sep 2014 - R. Yantosca - Make sure to turn on MEGAN SOA extension
#  07 Oct 2014 - R. Yantosca - Now use HEMCO tokens $ROOT, $MET, $RES
#  16 Oct 2014 - R. Yantosca - Remove scale factor 39 from LIANG_CH2Br2
#  16 Oct 2014 - R. Yantosca - Now point to new CAC_NH3.geos.1x1.nc file
#  20 Oct 2014 - R. Yantosca - Now read data from GFED3/v2014-10
#  03 Nov 2014 - R. Yantosca - Now use proper scale factors for CAC NO, CO SO2
#  12 Nov 2014 - R. Yantosca - Now emit BC and OC into hydrophilic tracers
#                              BCPI & OCPI.  Apply scale factors as needed
#                              to get hydrophobic tracers BCPO, OCPO.  
#  25 Nov 2014 - R. Yantosca - For Fullchem simulations: turned off MEGAN_SOA
#  05 Jan 2015 - R. Yantosca - Add GMI stratospheric Bry data
#  12 Jan 2015 - R. Yantosca - Now move strat Bry data to base emissions
#  20 Jan 2015 - M. Sulprizio- Update OTD-LIS factors through October 2014
#  20 Jan 2015 - M. Sulprizio- Update EMEP emissions for 2008-2010
#  05 Feb 2015 - M. Sulprizio- Update to EDGAR v4.2 emissions
#  16 Feb 2015 - C. Keller   - (a) Added data 'collections' (brackets).
#                              (b) Moved section extension switches at the
#                                  beginning.
#                              (c) Removed section extension data. These fields
#                                  are now listed in section base emissions.
#                              (d) Fields can now cover multiple categories.
#  19 Feb 2015 - R. Yantosca - Read EDGAR_BENZ from EDGAR/v2015-02/VOCv2
#  19 Feb 2015 - R. Yantosca - Read EDGAR_TODNOX from EDGAR/v2015-02/NO
#  25 Feb 2015 - M. Sulprizio- Update MEGAN2.1 emissions according to Guenther
#                              et al. (2012)
#  02 Mar 2015 - R. Yantosca - Add RCP and eruptive/degassing emissions info
#  04 Mar 2015 - R. Yantosca - Add UV albedo to the NON-EMISSIONS data section
#  11 Mar 2015 - M. Sulprizio- Add MIX Asian anthropogenic emissions and
#                              HTAP global anthropogenic emissions
#  11 Mar 2015 - C. Keller   - Added 'negative' bracket, e.g. data within a
#                              bracket leading by '--' is only considered if 
#                              this collection name is disabled.
#  13 Mar 2015 - C. Keller   - Added option to include other configuration 
#                              files by listing them as '>>>include CF_Name'.
#                              Added token '$CFDIR'. 
#  16 Mar 2015 - M. Sulprizio- Add mask file for MIX Asia region
#  16 Mar 2015 - M. Sulprizio- Now read variables for PARANOX and MEGAN from
#                              the HEMCO restart file
#  16 Mar 2015 - M. Sulprizio- Add GFED4 entries from Christoph Keller
#  16 Mar 2015 - R. Yantosca - Add TOMS/SBUV O3 columns
#  17 Mar 2015 - M. Sulprizio- Add NEI2011 entries from Christoph Keller
#  18 Mar 2015 - M. Sulprizio- Now use updated 2006-2013 NEI2011 annual scale
#                              factors from Katie Travis
#  24 Mar 2015 - M. Sulprizio- Reorder NEI2011 files so that we read all species
#                              for each sector before closing each netCDF file
#  26 Mar 2015 - M. Sulprizio- Add entry for STATE_PSC from Christoph Keller
#  27 Mar 2015 - M. Sulprizio- Revert to EMEP emissions in EMEP/v2014-07/
#  27 Mar 2015 - C. Keller   - Warnings are now 0-3
#  31 Mar 2015 - M. Sulprizio- Now use EMEP file from Aaron van Donkelaar with
#                              updated emissions for 2008-2012
#  08 Apr 2015 - R. Yantosca - Set units of STATE_PSC to "count"
#  15 Apr 2015 - R. Yantosca - Added _{NEST} token to HEMCO restart file
#  17 Apr 2015 - M. Sulprizio- Now read corrected AEIC file in AEIC/v2015-01/
#  21 Apr 2015 - R. Yantosca - Now can use extension names as switches
#  21 Apr 2015 - R. Yantosca - Now make section endings more visible
#  13 May 2015 - R. Yantosca - Fixed path of bromocarb scale factors
#  19 May 2015 - R. Yantosca - ICOADS_SHIP names now use "generic", not "gen"  
#  19 May 2015 - R. Yantosca - Add a note to only pick one biomass option 
#  19 May 2015 - R. Yantosca - Now use tokens for VERBOSE, WARNINGS            
#  20 May 2015 - M. Sulprizio- Change HTAP category from 1 to 1/2 since it
#                              includes anthro+biofuel emissions
#EOP
#------------------------------------------------------------------------------
#BOC
###############################################################################
### BEGIN SECTION SETTINGS
###############################################################################

ROOT:                        {ROOT}
Logfile:                     HEMCO.log
DiagnPrefix:                 HEMCO_diagnostics
DiagnFreq:                   End
Wildcard:                    *
Separator:                   /
Unit tolerance:              1
Negative values:             0
Only unitless scale factors: false
Verbose:                     {VERBOSE}
Warnings:                    {WARNINGS}

### END SECTION SETTINGS ###

###############################################################################
### BEGIN SECTION EXTENSION SWITCHES
###############################################################################
###
### This section lists all emission extensions available to HEMCO and whether 
### they shall be used or not. Extension 'base' must have extension number 
### zero, all other extension numbers can be freely chosen. Data fields in 
### section 'base emissions' will only be read if the corresponding extension 
### (identified by ExtNr) is enabled. Similarly, fields grouped into data 
### collections ('(((CollectionName', ')))CollectionName') are only considered
### if the corresponding data collection is enabled in this section. Data
### listed within a disabled extension are always ignored, even if they are
### grouped in an enabled collection (e.g. GFED-4 data will never be considered
### if the GFED extension is disabled, even if the GFED4 option is set to true).
###
### It is possible to define collections that are only evaluated if a
### collection name is *not* enabled. This is achieved by leading the
### collection name with '.not.', e.g. '(((.not.FINN_daily' ...
### '))).not.FINN_daily' for FINN monthly data (only used if daily data is
### not being used). 
###
### The ExtNr provided in this section must match with the ExtNr assigned to
### the data listed in the base emissions sections. Otherwise, the listed 
### files won't be read!
###
### NOTES:
### --> You can only select one biomass burning option (GFED, QFED, FINN).
###
### --> BOND_BIOMASS must be set to false if GFED, QFED, or FINN is enabled.
###
### --> The biomass burning POA scale factor is the same as for the biofuel 
###     and anthro sources. 
###
### --> The NAP scale factor is determined as in the original simulation:
###     Obtain NAP emissions using scale factor from Hays 2002 ES&T 
###     (0.0253 g NAP/kg DM) and Andreae and Merlet 2001 GBC (92 g CO/kg DM)
###############################################################################
# ExtNr ExtName           on/off  Species
0       Base              : on    *
    --> AEIC              :       true
    --> BIOFUEL           :       true
    --> BOND              :       true
    --> BRAVO             :       false
    --> CAC               :       false
    --> C2H6              :       true
    --> EDGAR             :       true
    --> HTAP              :       false
    --> EMEP              :       false
    --> GEIA              :       true
    --> LIANG_BROMOCARB   :       true
    --> NEI2005           :       false
    --> NEI2011           :       false
    --> RETRO             :       true 
    --> SHIP              :       true
    --> NEI2011_SHIP      :       false
    --> MIX               :       true
    --> STREETS           :       false
    --> VOLCANO           :       true
    --> RCP_3PD           :       false 
    --> RCP_45            :       false
    --> RCP_60            :       false
    --> RCP_85            :       false
# -----------------------------------------------------------------------------
100     Custom            : off   - 
101     SeaFlux           : on    DMS/ACET
102     ParaNOx           : on    NO/NO2/O3/HNO3
    --> LUT data format   :       nc
    --> LUT source dir    :       $ROOT/PARANOX/v2015-02
103     LightNOx          : on    NO
    --> OTD-LIS factors   :       true
    --> CDF table         :       $ROOT/LIGHTNOX/v2014-07/light_dist.ott2010.dat
104     SoilNOx           : on    NO 
    --> Use fertilizer NOx:       true
105     DustDead          : on    DST1/DST2/DST3/DST4 
106     DustGinoux        : off   DST1/DST2/DST3/DST4
107     SeaSalt           : on    SALA/SALC/Br2
    --> SALA lower radius :       0.01 
    --> SALA upper radius :       0.5
    --> SALC lower radius :       0.5
    --> SALC upper radius :       8.0
    --> Emit Br2          :       true  
    --> Br2 scaling       :       1.0 
108     MEGAN             : on    ISOP/ACET/PRPE/C2H4/ALD2
    --> Isoprene scaling  :       1.0 
109     MEGAN_Mono        : on    CO/OCPI/MONX
110     MEGAN_SOA         : off   MTPA/MTPO/LIMO/SESQ
111     GFED              : on    NO/CO/ALK4/ACET/MEK/ALD2/PRPE/C3H8/CH2O/C2H6/SO2/NH3/BCPO/BCPI/OCPO/OCPI/POA1/NAP
    --> GFED3             :       false 
    --> GFED4             :       true
    --> GFED_daily        :       false
    --> GFED_3hourly      :       false
    --> CO scale factor   :       1.05
    --> POA scale factor  :       1.27
    --> NAP scale factor  :       2.75e-4
    --> hydrophilic BC    :       0.2
    --> hydrophilic OC    :       0.5
114     FINN              : off   NO/CO/ALK4/ACET/MEK/ALD2/PRPE/C3H8/CH2O/C2H6/SO2/NH3/BCPI/BCPO/OCPI/OCPO/GLYC/HAC
    --> FINN_daily        :       false
    --> CO scale factor   :       1.0
    --> hydrophilic BC    :       0.2
    --> hydrophilic OC    :       0.5

### END SECTION EXTENSION SWITCHES ###

###############################################################################
### BEGIN SECTION BASE EMISSIONS 
###############################################################################

# ExtNr	Name sourceFile	sourceVar sourceTime C/R/E SrcDim SrcUnit Species ScalIDs Cat Hier

#==============================================================================
# --- MACCity ---
#==============================================================================
#0 MACCITY_NO $ROOT/MACCITY/v2014-07/MACCity_anthro_NOx_2000-2010_16080.nc MACCity 2000/1/1/0 C xy kg/m2/s NO - 1 2
#0 MACCITY_CO $ROOT/MACCITY/v2014-07/MACCity_anthro_CO_2000-2010_16080.nc  MACCity 2000/1/1/0 C xy kg/m2/s CO - 1 2 

#==============================================================================
# --- GEIA ---
#
# NOTE: These emissions are old and are slated to be replaced soon.
#==============================================================================
(((GEIA
#0 GEIA_NO   $ROOT/GEIA/v2014-07/GEIA_NOSO4.fullyear.geos.4x5.nc NO   1985/1-12/1/0 C xy  kg/m2/s  NO   1/2/25/20    1 1 
#0 GEIA_CO   $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         CO   1985/1/1/0    C xy  kg/m2/s  CO   6/7/26/21/52 1 1 
#0 GEIA_ALK4 $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         ALK4 1985/1/1/0    C xy  kgC/m2/s ALK4 918/26/22    1 1 
#0 GEIA_ACET $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         ACET 1985/1/1/0    C xy  kgC/m2/s ACET 918/26/55    1 1
#0 GEIA_PRPE $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         PRPE 1985/1/1/0    C xy  kgC/m2/s PRPE 918/26/22    1 1
#0 GEIA_MEK  $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         MEK  1985/1/1/0    C xy  kgC/m2/s MEK  918/26       1 1
#0 GEIA_C2H6 $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         C2H6 1985/1/1/0    C xy  kgC/m2/s C2H6 26           1 1
#0 GEIA_C3H8 $ROOT/GEIA/v2014-07/GEIA_FOSSIL.geos.1x1.nc         C3H8 1985/1/1/0    C xy  kgC/m2/s C3H8 918/26/22    1 1

# GEIA NH3 emissions: anthropogenic, biofuel and natural sources
0 GEIA_NH3_ANTH $ROOT/NH3/v2014-07/NH3_geos.4x5.nc         NH3_ANTH    1990/1-12/1/0 C xy  kg/m2/s NH3 - 1 1 

(((BIOFUEL
0 GEIA_NH3_BIOF $ROOT/NH3/v2014-07/NH3_biofuel.geos.4x5.nc NH3_BIOFUEL 1998/1-12/1/0 C xy  kg/m2/s NH3 - 2 1
)))BIOFUEL

0 GEIA_NH3_NATU $ROOT/NH3/v2014-07/NH3_geos.4x5.nc         NH3_NATU    1990/1-12/1/0 C xy  kg/m2/s NH3 - 3 1
)))GEIA

#==============================================================================
# --- EDGAR v4.2 ---
#
# %%% NOTE: Use EDGAR for the global base emissions instead of GEIA %%%
#
# Do not include the following sources (meng,3/6/2014)
#  - Non-road transportation emissions (1A3a_c_d_e). Instead, use
#    ICOADS/ARCTAS for ship emissions and AEIC for aircraft emisisons.
#  - Soil emissions of NOx (4C_4D). These emissions are calculated via the 
#    SoilNOx extension.
#  - Open biomass burning (4F, 5A_C_D_F_4E). These emissions are obtained from
#    GFED3 or FINN.
#==============================================================================
(((EDGAR
0 EDGAR_NO_1A1a            $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1A1a.generic.01x01.nc             emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_1A2             $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1A2.generic.01x01.nc              emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
#0 EDGAR_NO_1A3a_c_d_e     $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1A3a_c_d_e.generic.01x01.nc       emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_1A3b            $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1A3b.generic.01x01.nc             emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_1A4             $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1A4.generic.01x01.nc              emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_1B2a_c_1A1b_c   $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_1B2a_c_1A1b_c.generic.01x01.nc    emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_2               $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_2.generic.01x01.nc                emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_4B              $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_4B.generic.01x01.nc               emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
#0 EDGAR_NO_4C_4D          $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_4C_4D.generic.01x01.nc            emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
#0 EDGAR_NO_4F             $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_4F.generic.01x01.nc               emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
#0 EDGAR_NO_5A_C_D_F_4E    $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_5A_C_D_F_4E.generic.01x01.nc      emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_6A_6C           $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_6A_6C.generic.01x01.nc            emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_NO_7A              $ROOT/EDGARv42/v2015-02/NO/EDGAR_v42_NO_IPCC_7A.generic.01x01.nc               emi_no  1970-2008/1/1/0 C xy kg/m2/s NO  1/40/25/30  1 2
0 EDGAR_CO_1A1a_6          $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1A1a_6.generic.01x01.nc           emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_1A2             $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1A2.generic.01x01.nc              emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
#0 EDGAR_CO_1A3a_c_d_e     $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1A3a_c_d_e.generic.01x01.nc       emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_1A3b            $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1A3b.generic.01x01.nc             emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_1A4             $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1A4.generic.01x01.nc              emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_1B2a_c_1A1b_c   $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_1B2a_c_1A1b_c.generic.01x01.nc    emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_2A_2B_2D        $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_2A_2B_2D.generic.01x01.nc         emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_2C              $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_2C.generic.01x01.nc               emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
#0 EDGAR_CO_4F             $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_4F.generic.01x01.nc               emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
#0 EDGAR_CO_5A_C_D_F_4E    $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_5A_C_D_F_4E.generic.01x01.nc      emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_CO_7A              $ROOT/EDGARv42/v2015-02/CO/EDGAR_v42_CO_IPCC_7A.generic.01x01.nc               emi_co  1970-2008/1/1/0 C xy kg/m2/s CO  6/41/26/52  1 2
0 EDGAR_SO2_1A1a_6C        $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1A1a_6C.generic.01x01.nc        emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_1A1a_6C        -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_1A2            $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1A2.generic.01x01.nc            emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_1A2            -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
#0 EDGAR_SO2_1A3a_c_d_e    $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1A3a_c_d_e.generic.01x01.nc     emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
#0 EDGAR_SO4_1A3a_c_d_e    -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_1A3b           $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1A3b.generic.01x01.nc           emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_1A3b           -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_1A4            $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1A4.generic.01x01.nc            emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_1A4            -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_1B1_1B2_1A1b_c $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_1B1_1B2_1A1b_c.generic.01x01.nc emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_1B1_1B2_1A1b_c -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_2B_2D          $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_2B_2D.generic.01x01.nc          emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_2B_2D          -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_2C             $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_2C.generic.01x01.nc             emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_2C             -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
#0 EDGAR_SO2_4F            $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_4F.generic.01x01.nc             emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
#0 EDGAR_SO4_4F            -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
#0 EDGAR_SO2_5A_C_D_F_4E   $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_5A_C_D_F_4E.generic.01x01.nc    emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
#0 EDGAR_SO4_5A_C_D_F_4E   -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_SO2_7A             $ROOT/EDGARv42/v2015-02/SO2/EDGAR_v42_SO2_IPCC_7A.generic.01x01.nc             emi_so2 1970-2008/1/1/0 C xy kg/m2/s SO2 11/42/31    1 2
0 EDGAR_SO4_7A             -                                                                              -       -               - -  -       SO4 11/42/31/63 1 2 
0 EDGAR_NH3_1A1a_6         $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_1A1a_6.generic.01x01.nc         emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_1A1b_c         $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_1A1b_c.generic.01x01.nc         emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_1A2            $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_1A2.generic.01x01.nc            emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_1A3            $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_1A3.generic.01x01.nc            emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_1A4            $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_1A4.generic.01x01.nc            emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_2A             $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_2A.generic.01x01.nc             emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_2B             $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_2B.generic.01x01.nc             emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_4B             $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_4B.generic.01x01.nc             emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
0 EDGAR_NH3_4C_4D          $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_4C_4D.generic.01x01.nc          emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
#0 EDGAR_NH3_4F            $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_4F.generic.01x01.nc             emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2
#0 EDGAR_NH3_5A_C_D_F_4E   $ROOT/EDGARv42/v2015-02/NH3/EDGAR_v42_NH3_IPCC_5A_C_D_F_4E.generic.01x01.nc    emi_nh3 1970-2008/1/1/0 C xy kg/m2/s NH3 38          1 2

#==============================================================================
# --- NAP ANTHROPOGENIC EMISSIONS: approximate from EDGAR BENZ --- 
#
# NOTE: Although this data comes from EDGAR version 2, we are storing it
# in the EDGARv42 data path for convenience.  That way you do not need to
# download the older EDGAR data directory, in order to save disk space.
#==============================================================================
0 EDGAR_NAP $ROOT/EDGARv42/v2015-02/VOCv2/EDGAR2_1985_FF_IND.1x1geos.nc BENZ 1985/1/1/0 C xy kgC/m2/s NAP 80/81/82 1 2
)))EDGAR

#==============================================================================
# --- HTAP v2 ---
#
# %%% NOTE: This is an optional inventory. You may select either EDGAR or HTAP
# for the global base emissions %%%
#
# ==> HTAP ship emissions are listed in the ship emissions section below
# ==> Disable aircraft emissions and get them from AEIC instead.
#==============================================================================
(((HTAP
0 HTAP_NO_IND    $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_INDUSTRY.generic.01x01.nc      emi_no  2008-2010/1-12/1/0 C xy kg/m2/s NO  1/27/25  1/2 4
0 HTAP_NO_POW    $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_ENERGY.generic.01x01.nc        emi_no  2008-2010/1-12/1/0 C xy kg/m2/s NO  1/27/25  1/2 4
0 HTAP_NO_RES    $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_RESIDENTIAL.generic.01x01.nc   emi_no  2008-2010/1-12/1/0 C xy kg/m2/s NO  1/27/25  1/2 4
0 HTAP_NO_TRA    $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_TRANSPORT.generic.01x01.nc     emi_no  2008-2010/1-12/1/0 C xy kg/m2/s NO  1/27/25  1/2 4
#0 HTAP_NO_AIR1  $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_AIR_LTO.generic.01x01.nc       emi_no  2008-2010/1/1/0    C xy kg/m2/s NO  1/27/25  1/2 4
#0 HTAP_NO_AIR2  $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_AIR_CDS.generic.01x01.nc       emi_no  2008-2010/1/1/0    C xy kg/m2/s NO  1/27/25  1/2 4
#0 HTAP_NO_AIR3  $ROOT/HTAP/v2015-03/NO/EDGAR_HTAP_NO_AIR_CRS.generic.01x01.nc       emi_no  2008-2010/1/1/0    C xy kg/m2/s NO  1/27/25  1/2 4
0 HTAP_CO_IND    $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_INDUSTRY.generic.01x01.nc      emi_co  2008-2010/1-12/1/0 C xy kg/m2/s CO  6/28/26  1/2 4
0 HTAP_CO_POW    $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_ENERGY.generic.01x01.nc        emi_co  2008-2010/1-12/1/0 C xy kg/m2/s CO  6/28/26  1/2 4
0 HTAP_CO_RES    $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_RESIDENTIAL.generic.01x01.nc   emi_co  2008-2010/1-12/1/0 C xy kg/m2/s CO  6/28/26  1/2 4
0 HTAP_CO_TRA    $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_TRANSPORT.generic.01x01.nc     emi_co  2008-2010/1-12/1/0 C xy kg/m2/s CO  6/28/26  1/2 4
#0 HTAP_CO_AIR1  $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_AIR_LTO.generic.01x01.nc       emi_co  2008-2010/1/1/0    C xy kg/m2/s CO  6/28/26  1/2 4
#0 HTAP_CO_AIR2  $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_AIR_CDS.generic.01x01.nc       emi_co  2008-2010/1/1/0    C xy kg/m2/s CO  6/28/26  1/2 4
#0 HTAP_CO_AIR3  $ROOT/HTAP/v2015-03/CO/EDGAR_HTAP_CO_AIR_CRS.generic.01x01.nc       emi_co  2008-2010/1/1/0    C xy kg/m2/s CO  6/28/26  1/2 4
0 HTAP_SO2_IND   $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_INDUSTRY.generic.01x01.nc    emi_so2 2008-2010/1-12/1/0 C xy kg/m2/s SO2 11/29    1/2 4
0 HTAP_SO4_IND   -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
0 HTAP_SO2_POW   $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_ENERGY.generic.01x01.nc      emi_so2 2008-2010/1-12/1/0 C xy kg/m2/s SO2 11/29    1/2 4
0 HTAP_SO4_POW   -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
0 HTAP_SO2_RES   $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_RESIDENTIAL.generic.01x01.nc emi_so2 2008-2010/1-12/1/0 C xy kg/m2/s SO2 11/29    1/2 4
0 HTAP_SO4_RES   -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
0 HTAP_SO2_TRA   $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_TRANSPORT.generic.01x01.nc   emi_so2 2008-2010/1-12/1/0 C xy kg/m2/s SO2 11/29    1/2 4
0 HTAP_SO4_TRA   -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
#0 HTAP_SO2_AIR1 $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_AIR_LTO.generic.01x01.nc     emi_so2 2008-2010/1/1/0    C xy kg/m2/s SO2 11/29    1/2 4
#0 HTAP_SO4_AIR1 -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
#0 HTAP_SO2_AIR2 $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_AIR_CDS.generic.01x01.nc     emi_so2 2008-2010/1/1/0    C xy kg/m2/s SO2 11/29    1/2 4
#0 HTAP_SO4_AIR2 -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
#0 HTAP_SO2_AIR3 $ROOT/HTAP/v2015-03/SO2/EDGAR_HTAP_SO2_AIR_CRS.generic.01x01.nc     emi_so2 2008-2010/1/1/0    C xy kg/m2/s SO2 11/29    1/2 4
#0 HTAP_SO4_AIR3 -                                                                   -       -                  - -  -       SO4 11/29/63 1/2 4
0 HTAP_NH3_IND   $ROOT/HTAP/v2015-03/NH3/EDGAR_HTAP_NH3_INDUSTRY.generic.01x01.nc    emi_nh3 2008-2010/1-12/1/0 C xy kg/m2/s NH3 -        1/2 4
0 HTAP_NH3_POW   $ROOT/HTAP/v2015-03/NH3/EDGAR_HTAP_NH3_ENERGY.generic.01x01.nc      emi_nh3 2008-2010/1-12/1/0 C xy kg/m2/s NH3 -        1/2 4
0 HTAP_NH3_RES   $ROOT/HTAP/v2015-03/NH3/EDGAR_HTAP_NH3_RESIDENTIAL.generic.01x01.nc emi_nh3 2008-2010/1-12/1/0 C xy kg/m2/s NH3 -        1/2 4
0 HTAP_NH3_TRA   $ROOT/HTAP/v2015-03/NH3/EDGAR_HTAP_NH3_TRANSPORT.generic.01x01.nc   emi_nh3 2008-2010/1-12/1/0 C xy kg/m2/s NH3 -        1/2 4
0 HTAP_NH3_AGR   $ROOT/HTAP/v2015-03/NH3/EDGAR_HTAP_NH3_AGRICULTURE.generic.01x01.nc emi_nh3 2008-2010/1-12/1/0 C xy kg/m2/s NH3 -        1/2 4
)))HTAP

#==============================================================================
# --- BIOFUEL EMISSIONS (Yevich and Logan, 2003) ---
#
# ==> Note that this inventory does not contain emissions over the US!!
#     Add to EDGAR emissions, i.e assign same category and hierarchy as EDGAR!
#     Don't read VOCs that are included in RETRO!!
#
# ==> It turns out that biofuel SO2 emissions in some regions are very 
#     different (up to a factor of 2 for some grid boxes) when using the 
#     high-resolution biofuel field compared to the 4x5 degrees input file. 
#     For backwards consistency, I'd recommend using the 4x5 biofuel file 
#     instead of the 1x1 file.
#        -- Christoph Keller (03 Nov 2014)
#==============================================================================
(((BIOFUEL
0 BIOFUEL_NO   $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_NO   1985/1/1/0 C xy kg/m2/s  NO   -  2 1
0 BIOFUEL_CO   $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_CO   1985/1/1/0 C xy kg/m2/s  CO   53 2 1
0 BIOFUEL_SO2  -                                          -            -          - -  -        SO2  91 2 1
0 BIOFUEL_GLYX -                                          -            -          - -  -        GLYX 92 2 1
0 BIOFUEL_MGLY -                                          -            -          - -  -        MGLY 93 2 1
0 BIOFUEL_NAP  -                                          -            -          - -  -        NAP  80/81/83 2 1
0 BIOFUEL_GLYC -                                          -            -          - -  -        GLYC 99 2 1
0 BIOFUEL_HAC  -                                          -            -          - -  -        HAC  90 2 1
0 BIOFUEL_BENZ -                                          -            -          - -  -        BENZ 94 2 1
0 BIOFUEL_TOLU -                                          -            -          - -  -        TOLU 95 2 1
0 BIOFUEL_XYLE -                                          -            -          - -  -        XYLE 96 2 1
0 BIOFUEL_C2H4 -                                          -            -          - -  -        C2H4 97 2 1
0 BIOFUEL_C2H2 -                                          -            -          - -  -        C2H2 98 2 1
0 BIOFUEL_ALK4 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_ALK4 1985/1/1/0 C xy kgC/m2/s ALK4 -  2 1
0 BIOFUEL_ACET $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_ACET 1985/1/1/0 C xy kgC/m2/s ACET 56 2 1
0 BIOFUEL_MEK  $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_MEK  1985/1/1/0 C xy kgC/m2/s MEK  -  2 1
0 BIOFUEL_ALD2 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_ALD2 1985/1/1/0 C xy kgC/m2/s ALD2 -  2 1
0 BIOFUEL_PRPE $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_PRPE 1985/1/1/0 C xy kgC/m2/s PRPE -  2 1
0 BIOFUEL_C3H8 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_C3H8 1985/1/1/0 C xy kgC/m2/s C3H8 -  2 1
0 BIOFUEL_CH2O $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_CH2O 1985/1/1/0 C xy kg/m2/s  CH2O -  2 1
0 BIOFUEL_C2H6 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc BIOFUEL_C2H6 1985/1/1/0 C xy kgC/m2/s C2H6 -  2 1
)))BIOFUEL

#==============================================================================
# --- RETRO ---
#
# NOTE: RETRO lumps biofuel emissions in with the anthro emissions
#==============================================================================
(((RETRO
0 RETRO_ALK4__A $ROOT/RETRO/v2014-07/orig_kgC/butanes_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s ALK4 26    1/2 3  
0 RETRO_ALK4__B $ROOT/RETRO/v2014-07/orig_kgC/pentanes_kgC.nc emission_flux 2000/1-12/1/0 C xy kgC/m2/s ALK4 26    1/2 3  
0 RETRO_ALK4__C $ROOT/RETRO/v2014-07/orig_kgC/hexanes_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s ALK4 26    1/2 3 
0 RETRO_ACET    $ROOT/RETRO/v2014-07/orig_kgC/ketones_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s ACET 26/51 1/2 3 
0 RETRO_MEK     -                                             -             -             - -  -        MEK  26/50 1/2 3
0 RETRO_ALD2    $ROOT/RETRO/v2014-07/orig_kgC/alkanals_kgC.nc emission_flux 2000/1-12/1/0 C xy kgC/m2/s ALD2 26    1/2 3 
0 RETRO_PRPE    $ROOT/RETRO/v2014-07/orig_kgC/propene_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s PRPE 26    1/2 3 
0 RETRO_C3H8    $ROOT/RETRO/v2014-07/orig_kgC/propane_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s C3H8 26    1/2 3 
0 RETRO_CH2O    $ROOT/RETRO/v2014-07/orig_kgC/methanal.nc     emission_flux 2000/1-12/1/0 C xy kg/m2/s  CH2O 26    1/2 3 
0 RETRO_BENZ    $ROOT/RETRO/v2014-07/orig_kgC/benzene_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s BENZ 26    1/2 3 
0 RETRO_TOLU    $ROOT/RETRO/v2014-07/orig_kgC/toluene_kgC.nc  emission_flux 2000/1-12/1/0 C xy kgC/m2/s TOLU 26    1/2 3 
0 RETRO_XYLE    $ROOT/RETRO/v2014-07/orig_kgC/xylene_kgC.nc   emission_flux 2000/1-12/1/0 C xy kgC/m2/s XYLE 26    1/2 3 
0 RETRO_C2H4    $ROOT/RETRO/v2014-07/orig_kgC/ethene_kgC.nc   emission_flux 2000/1-12/1/0 C xy kgC/m2/s C2H4 26    1/2 3 
0 RETRO_C2H2    $ROOT/RETRO/v2014-07/orig_kgC/ethyne_kgC.nc   emission_flux 2000/1-12/1/0 C xy kgC/m2/s C2H2 26    1/2 3 
0 RETRO_C2H6    $ROOT/RETRO/v2014-07/orig_kgC/ethane_kgC.nc   emission_flux 2000/1-12/1/0 C xy kgC/m2/s C2H6 26    1/2 3 
)))RETRO

#==============================================================================
# --- Xiao et al., JGR, 2008 ---
#
# NOTE: Xiao et al C2H6 is used in place of RETRO C2H6
# See: http://wiki.geos-chem.org/Implementation_of_RETRO_Anthropogenic_Emissions#RETRO_anthropogenic_ethane_emissions_are_too_low
#==============================================================================
(((C2H6
0  XIAO_C2H6    $ROOT/XIAO/v2014-09/C3H8_C2H6_ngas.geos.1x1.nc C2H6         1985/1/1/0 C xy kgC/m2/s C2H6 26        1 1000
#0 XIAO_C3H8    $ROOT/XIAO/v2014-09/C3H8_C2H6_ngas.geos.1x1.nc C3H8         1985/1/1/0 C xy kgC/m2/s C3H8 6/7/26/22 1 1000
(((BIOFUEL
0  BIOFUEL_C2H6 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc     BIOFUEL_C2H6 1985/1/1/0 C xy kgC/m2/s C2H6 -         2 1000
#0 BIOFUEL_C3H8 $ROOT/BIOFUEL/v2014-07/biofuel.geos.4x5.nc     BIOFUEL_C3H8 1985/1/1/0 C xy kgC/m2/s C3H8 -         2 1000
)))BIOFUEL
)))C2H6

#==============================================================================
# --- EMEP (Europe) ---
#==============================================================================
(((EMEP
0 EMEP_NO   $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc NO   1990-2012/1/1/0 C xy kg/m2/s  NO   25/32/1000    1/2 10
0 EMEP_CO   $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc CO   1990-2012/1/1/0 C xy kg/m2/s  CO   26/33/52/1000 1/2 10 
0 EMEP_SO2  $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc SO2  1990-2012/1/1/0 C xy kg/m2/s  SO2  61/35/1000    1/2 10
0 EMEP_SO4  -                                       -    -               - -  -        SO4  64/35/1000    1/2 10
0 EMEP_ALK4 $ROOT/EMEP/v2015-03/EMEP.geos.1x1.nc    ALK4 1980-2000/1/1/0 C xy kgC/m2/s ALK4 26/1000       1/2 10
0 EMEP_ALD2 $ROOT/EMEP/v2015-03/EMEP.geos.1x1.nc    ALD2 1980-2000/1/1/0 C xy kgC/m2/s ALD2 26/1000       1/2 10
0 EMEP_PRPE $ROOT/EMEP/v2015-03/EMEP.geos.1x1.nc    PRPE 1980-2000/1/1/0 C xy kgC/m2/s PRPE 26/1000       1/2 10
0 EMEP_MEK  $ROOT/EMEP/v2015-03/EMEP.geos.1x1.nc    MEK  1980-2000/1/1/0 C xy kgC/m2/s MEK  26/1000       1/2 10
0 EMEP_NH3  $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc NH3  1990-2012/1/1/0 C xy kg/m2/s  NH3  34/1000       1/2 10
)))EMEP

#==============================================================================
# --- BRAVO (Mexico) ---
#==============================================================================
(((BRAVO
0 BRAVO_NO  $ROOT/BRAVO/v2014-07/BRAVO.generic.1x1.nc NO  1999/1/1/0 C xy kg/m2/s NO  1/3/25/1001    1/2 20
0 BRAVO_CO  $ROOT/BRAVO/v2014-07/BRAVO.generic.1x1.nc CO  1999/1/1/0 C xy kg/m2/s CO  6/8/26/52/1001 1/2 20
0 BRAVO_SO2 $ROOT/BRAVO/v2014-07/BRAVO.generic.1x1.nc SO2 1999/1/1/0 C xy kg/m2/s SO2 11/13/1001     1/2 20
0 BRAVO_SO4 -                                         -   -          - -  -       SO4 11/13/65/1001  1/2 20
)))BRAVO

#==============================================================================
# --- CAC (Canada) ---
#==============================================================================
(((CAC
0 CAC_NO  $ROOT/CAC/v2014-07/CAC.geos.1x1.nc     NO  2002-2008/1/1/0 C xy kg/m2/s NO  1/24/25/1002    1/2 30
0 CAC_CO  $ROOT/CAC/v2014-07/CAC.geos.1x1.nc     CO  2002-2008/1/1/0 C xy kg/m2/s CO  6/23/26/52/1002 1/2 30
0 CAC_SO2 $ROOT/CAC/v2014-07/CAC.geos.1x1.nc     SOx 2002-2008/1/1/0 C xy kg/m2/s SO2 11/19/60/1002   1/2 30
0 CAC_SO4 -                                      -   -               - -  -       SO4 60/65/1002      1/2 30
0 CAC_NH3 $ROOT/CAC/v2014-07/CAC_NH3.geos.1x1.nc NH3 2008/1-12/1/0   C xy kg/m2/s NH3 1002            1/2 30
)))CAC

#==============================================================================
# --- NEI 2005 (USA) ---
#
# NOTE: Need to apply the GEIA_TOD_FOSSIL scale factor (#26)! 
# done for CO, need to check others
#==============================================================================
(((NEI2005
0 NEI2005_NO   $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    NO   2005/1/1/0 C xy kg/m2/s  NO   1/16/201/202/210/1005 1 35
0 NEI2005_CO   $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    CO   2005/1/1/0 C xy kg/m2/s  CO   6/26/17/211/230/1005  1 35
0 NEI2005_SO2  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    SO2  2005/1/1/0 C xy kg/m2/s  SO2  11/18/218/237/1005    1 35
0 NEI2005_SO4  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    SO4  2005/1/1/0 C xy kg/m2/s  SO4  11/18/219/238/1005    1 35
0 NEI2005_NH3  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    NH3  2005/1/1/0 C xy kg/m2/s  NH3  242/1005              1 35
0 NEI2005_ACET $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    ACET 2005/1/1/0 C xy kgC/m2/s ACET 213/232/1005          1 35
0 NEI2005_ALK4 $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    ALK4 2005/1/1/0 C xy kgC/m2/s ALK4 212/231/1005          1 35
#0 NEI2005_C2H6 $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc   C2H6 2005/1/1/0 C xy kgC/m2/s C2H6 217/236/1005          1 35
0 NEI2005_C3H8 $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    C3H8 2005/1/1/0 C xy kgC/m2/s C3H8 216/235/1005          1 35
#0 NEI2005_OC  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    OCPI 2005/1/1/0 C xy kg/m2/s  OCPI 222/241/1005          1 35
#0 NEI2005_BC  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    BCPI 2005/1/1/0 C xy kg/m2/s  BCPI 221/240/1005          1 35
0 NEI2005_ALD2 $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    ALD2 2005/1/1/0 C xy kgC/m2/s ALD2 1005                  1 35
0 NEI2005_CH2O $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    CH2O 2005/1/1/0 C xy kg/m2/s  CH2O 1005                  1 35
0 NEI2005_PRPE $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    PRPE 2005/1/1/0 C xy kgC/m2/s PRPE 215/234/1005          1 35
0 NEI2005_MEK  $ROOT/NEI2005/v2014-09/NEI2005.geos.1x1.1L.nc    MEK  2005/1/1/0 C xy kgC/m2/s MEK  214/233/1005          1 35
)))NEI2005

#==============================================================================
# --- NEI 2011 (USA) ---
#==============================================================================
(((NEI2011
# SURFACE INVENTORY
0 NEI11_SURFACE_NO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          NO       2006-2013/1-12/1-31/$HH R xy  kg/m2/s  NO   251/1007     1/2 50
0 NEI11_SURFACE_NO2    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          NO2      2006-2013/1-12/1-31/$HH R xy  kg/m2/s  NO2  251/1007     1/2 50
0 NEI11_SURFACE_HONO   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          HONO     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  HNO2 1007         1/2 50
0 NEI11_SURFACE_CO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          CO       2006-2013/1-12/1-31/$HH R xy  kg/m2/s  CO   252/1007     1/2 50
0 NEI11_SURFACE_NH3    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          NH3      2006-2013/1-12/1-31/$HH R xy  kg/m2/s  NH3  253/1007     1/2 50
0 NEI11_SURFACE_CH2O   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          FORM     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  CH2O 254/1007     1/2 50
0 NEI11_SURFACE_RCHO   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ALDX     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  RCHO 254/1007     1/2 50
0 NEI11_SURFACE_MACR   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ACROLEIN 2006-2013/1-12/1-31/$HH R xy  kg/m2/s  MACR 254/1007     1/2 50
0 NEI11_SURFACE_ACET   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          PAR      2006-2013/1-12/1-31/$HH R xy  kgC/m2/s ACET 254/1007/260 1/2 50
0 NEI11_SURFACE_C3H8   -                                                               -        -                       - -   -        C3H8 254/1007/261 1/2 50
0 NEI11_SURFACE_MEK    -                                                               -        -                       - -   -        MEK  254/1007/262 1/2 50
0 NEI11_SURFACE_ALK4   -                                                               -        -                       - -   -        ALK4 254/1007/263 1/2 50
0 NEI11_SURFACE_PRPE   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          OLE      2006-2013/1-12/1-31/$HH R xy  kgC/m2/s PRPE 254/1007/264 1/2 50
0 NEI11_SURFACE_PRP2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          IOLE     2006-2013/1-12/1-31/$HH R xy  kgC/m2/s PRPE 254/1007/264 1/2 50
0 NEI11_SURFACE_EOH    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ETOH     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  EOH  254/1007     1/2 50
0 NEI11_SURFACE_MOH    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          MEOH     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  MOH  254/1007     1/2 50
0 NEI11_SURFACE_XYLE   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          XYL      2006-2013/1-12/1-31/$HH R xy  kgC/m2/s XYLE 254/1007     1/2 50
0 NEI11_SURFACE_TOLU   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          TOL      2006-2013/1-12/1-31/$HH R xy  kgC/m2/s TOLU 254/1007     1/2 50
0 NEI11_SURFACE_BENZ   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          BENZENE  2006-2013/1-12/1-31/$HH R xy  kgC/m2/s BENZ 254/1007     1/2 50
0 NEI11_SURFACE_SO2    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          SO2      2006-2013/1-12/1-31/$HH R xy  kg/m2/s  SO2  255/1007     1/2 50
0 NEI11_SURFACE_SULF   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          SULF     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  SO2  255/1007     1/2 50
0 NEI11_SURFACE_SO4    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          PSO4     2006-2013/1-12/1-31/$HH R xy  kg/m2/s  SO4  255/1007     1/2 50
0 NEI11_SURFACE_C2H4   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ETH      2006-2013/1-12/1-31/$HH R xy  kgC/m2/s C2H4 254/1007     1/2 50
0 NEI11_SURFACE_C2H6   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ETHA     2006-2013/1-12/1-31/$HH R xy  kgC/m2/s C2H6 254/1007     1/2 50
0 NEI11_SURFACE_ALD2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          ALD2     2006-2013/1-12/1-31/$HH R xy  kgC/m2/s ALD2 254/1007     1/2 50
0 NEI11_SURFACE_BCPI   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          PEC      2006-2013/1-12/1-31/$HH R xy  kg/m2/s  BCPI 256/1007/265 1/2 50
0 NEI11_SURFACE_BCPO   -                                                               -        -                       - -   -        BCPO 256/1007/266 1/2 50
0 NEI11_SURFACE_OCPI   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD.nc          POC      2006-2013/1-12/1-31/$HH R xy  kg/m2/s  OCPI 257/1007/267 1/2 50
0 NEI11_SURFACE_OCPO   -                                                               -        -                       - -   -        OCPO 257/1007/268 1/2 50

# ELECTRIC GENERATING UNITS (EGUs)
0 NEI11_EGU_NO         $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      NO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO   251/1007     1   50
0 NEI11_EGU_NO2        $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      NO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO2  251/1007     1   50
0 NEI11_EGU_HONO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      HONO     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  HNO2 1007         1   50
0 NEI11_EGU_CO         $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      CO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CO   252/1007     1   50
#0 NEI11_EGU_NH3       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      NH3      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NH3  253/1007     1   50
0 NEI11_EGU_CH2O       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      FORM     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CH2O 254/1007     1   50
0 NEI11_EGU_RCHO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ALDX     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  RCHO 254/1007     1   50
0 NEI11_EGU_MACR       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ACROLEIN 2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MACR 254/1007     1   50
0 NEI11_EGU_ACET       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      PAR      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ACET 254/1007/260 1   50
0 NEI11_EGU_C3H8       -                                                               -        -                       - -   -        C3H8 254/1007/261 1   50
0 NEI11_EGU_MEK        -                                                               -        -                       - -   -        MEK  254/1007/262 1   50
0 NEI11_EGU_ALK4       -                                                               -        -                       - -   -        ALK4 254/1007/263 1   50
0 NEI11_EGU_PRPE       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      OLE      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_EGU_PRP2       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      IOLE     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_EGU_EOH        $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ETOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  EOH  254/1007     1   50
0 NEI11_EGU_MOH        $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      MEOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MOH  254/1007     1   50
0 NEI11_EGU_XYLE       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      XYL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s XYLE 254/1007     1   50
0 NEI11_EGU_TOLU       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      TOL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s TOLU 254/1007     1   50
0 NEI11_EGU_BENZ       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      BENZENE  2006-2013/1-12/1-31/$HH R xyz kgC/m2/s BENZ 254/1007     1   50
0 NEI11_EGU_SO2        $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      SO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_EGU_SULF       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      SULF     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_EGU_SO4        $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      PSO4     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO4  255/1007     1   50
0 NEI11_EGU_C2H4       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ETH      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H4 254/1007     1   50
0 NEI11_EGU_C2H6       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ETHA     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H6 254/1007     1   50
0 NEI11_EGU_ALD2       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      ALD2     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ALD2 254/1007     1   50
0 NEI11_EGU_BCPI       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      PEC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  BCPI 256/1007/265 1   50
0 NEI11_EGU_BCPO       -                                                               -        -                       - -   -        BCPO 256/1007/266 1   50
0 NEI11_EGU_OCPI       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egu.nc      POC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  OCPI 257/1007/267 1   50
0 NEI11_EGU_OCPO       -                                                               -        -                       - -   -        OCPO 257/1007/268 1   50

# PEAKING ELECTRIC GENERATING UNITS
0 NEI11_EGUPK_NO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    NO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO   251/1007     1   50
0 NEI11_EGUPK_NO2      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    NO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO2  251/1007     1   50
0 NEI11_EGUPK_HONO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    HONO     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  HNO2 1007         1   50
0 NEI11_EGUPK_CO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    CO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CO   252/1007     1   50
#0 NEI11_EGUPK_NH3     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    NH3      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NH3  253/1007     1   50
0 NEI11_EGUPK_CH2O     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    FORM     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CH2O 254/1007     1   50
0 NEI11_EGUPK_RCHO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ALDX     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  RCHO 254/1007     1   50
0 NEI11_EGUPK_MACR     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ACROLEIN 2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MACR 254/1007     1   50
0 NEI11_EGUPK_ACET     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    PAR      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ACET 254/1007/260 1   50
0 NEI11_EGUPK_C3H8     -                                                               -        -                       - -   -        C3H8 254/1007/261 1   50
0 NEI11_EGUPK_MEK      -                                                               -        -                       - -   -        MEK  254/1007/262 1   50
0 NEI11_EGUPK_ALK4     -                                                               -        -                       - -   -        ALK4 254/1007/263 1   50
0 NEI11_EGUPK_PRPE     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    OLE      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_EGUPK_PRP2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    IOLE     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_EGUPK_EOH      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ETOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  EOH  254/1007     1   50
0 NEI11_EGUPK_MOH      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    MEOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MOH  254/1007     1   50
0 NEI11_EGUPK_XYLE     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    XYL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s XYLE 254/1007     1   50
0 NEI11_EGUPK_TOLU     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    TOL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s TOLU 254/1007     1   50
0 NEI11_EGUPK_BENZ     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    BENZENE  2006-2013/1-12/1-31/$HH R xyz kgC/m2/s BENZ 254/1007     1   50
0 NEI11_EGUPK_SO2      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    SO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_EGUPK_SULF     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    SULF     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_EGUPK_SO4      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    PSO4     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO4  255/1007     1   50
0 NEI11_EGUPK_C2H4     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ETH      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H4 254/1007     1   50
0 NEI11_EGUPK_C2H6     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ETHA     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H6 254/1007     1   50
0 NEI11_EGUPK_ALD2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    ALD2     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ALD2 254/1007     1   50
0 NEI11_EGUPK_BCPI     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    PEC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  BCPI 256/1007/265 1   50
0 NEI11_EGUPK_BCPO     -                                                               -        -                       - -   -        BCPO 256/1007/266 1   50
0 NEI11_EGUPK_OCPI     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_egupk.nc    POC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  OCPI 257/1007/267 1   50
0 NEI11_EGUPK_OCPO     -                                                               -        -                       - -   -        OCPO 257/1007/268 1   50

# OIL & GAS
0 NEI11_OILGAS_NO      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   NO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO   251/1007     1   50
0 NEI11_OILGAS_NO2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   NO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO2  251/1007     1   50
0 NEI11_OILGAS_HONO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   HONO     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  HNO2 1007         1   50
0 NEI11_OILGAS_CO      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   CO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CO   252/1007     1   50
0 NEI11_OILGAS_NH3     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   NH3      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NH3  253/1007     1   50
0 NEI11_OILGAS_CH2O    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   FORM     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CH2O 254/1007     1   50
0 NEI11_OILGAS_RCHO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ALDX     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  RCHO 254/1007     1   50
#0 NEI11_OILGAS_MACR   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ACROLEIN 2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MACR 254/1007     1   50
0 NEI11_OILGAS_ACET    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   PAR      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ACET 254/1007/260 1   50
0 NEI11_OILGAS_C3H8    -                                                               -        -                       - -   -        C3H8 254/1007/261 1   50
0 NEI11_OILGAS_MEK     -                                                               -        -                       - -   -        MEK  254/1007/262 1   50
0 NEI11_OILGAS_ALK4    -                                                               -        -                       - -   -        ALK4 254/1007/263 1   50
0 NEI11_OILGAS_PRPE    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   OLE      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_OILGAS_PRP2    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   IOLE     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_OILGAS_EOH     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ETOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  EOH  254/1007     1   50
0 NEI11_OILGAS_MOH     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   MEOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MOH  254/1007     1   50
0 NEI11_OILGAS_XYLE    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   XYL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s XYLE 254/1007     1   50
0 NEI11_OILGAS_TOLU    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   TOL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s TOLU 254/1007     1   50
0 NEI11_OILGAS_BENZ    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   BENZENE  2006-2013/1-12/1-31/$HH R xyz kgC/m2/s BENZ 254/1007     1   50
0 NEI11_OILGAS_SO2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   SO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_OILGAS_SULF    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   SULF     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_OILGAS_SO4     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   PSO4     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO4  255/1007     1   50
0 NEI11_OILGAS_C2H4    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ETH      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H4 254/1007     1   50
0 NEI11_OILGAS_C2H6    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ETHA     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H6 254/1007     1   50
0 NEI11_OILGAS_ALD2    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   ALD2     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ALD2 254/1007     1   50
0 NEI11_OILGAS_BCPI    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   PEC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  BCPI 256/1007/265 1   50
0 NEI11_OILGAS_BCPO    -                                                               -        -                       - -   -        BCPO 256/1007/266 1   50
0 NEI11_OILGAS_OCPI    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_oilgas.nc   POC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  OCPI 257/1007/267 1   50
0 NEI11_OILGAS_OCPO    -                                                               -        -                       - -   -        OCPO 257/1007/268 1   50

# OTHER POINT SOURCES
0 NEI11_OTHPT_NO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    NO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO   251/1007     1   50
0 NEI11_OTHPT_NO2      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    NO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO2  251/1007     1   50
0 NEI11_OTHPT_HONO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    HONO     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  HNO2 1007         1   50
0 NEI11_OTHPT_CO       $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    CO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CO   252/1007     1   50
0 NEI11_OTHPT_NH3      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    NH3      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NH3  253/1007     1   50
0 NEI11_OTHPT_CH2O     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    FORM     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CH2O 254/1007     1   50
0 NEI11_OTHPT_RCHO     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ALDX     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  RCHO 254/1007     1   50
#0 NEI11_OTHPT_MACR    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ACROLEIN 2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MACR 254/1007     1   50
0 NEI11_OTHPT_ACET     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    PAR      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ACET 254/1007/260 1   50
0 NEI11_OTHPT_C3H8     -                                                               -        -                       - -   -        C3H8 254/1007/261 1   50
0 NEI11_OTHPT_MEK      -                                                               -        -                       - -   -        MEK  254/1007/262 1   50
0 NEI11_OTHPT_ALK4     -                                                               -        -                       - -   -        ALK4 254/1007/263 1   50
0 NEI11_OTHPT_PRPE     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    OLE      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_OTHPT_PRP2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    IOLE     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_OTHPT_EOH      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ETOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  EOH  254/1007     1   50
0 NEI11_OTHPT_MOH      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    MEOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MOH  254/1007     1   50
0 NEI11_OTHPT_XYLE     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    XYL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s XYLE 254/1007     1   50
0 NEI11_OTHPT_TOLU     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    TOL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s TOLU 254/1007     1   50
0 NEI11_OTHPT_BENZ     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    BENZENE  2006-2013/1-12/1-31/$HH R xyz kgC/m2/s BENZ 254/1007     1   50
0 NEI11_OTHPT_SO2      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    SO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_OTHPT_SULF     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    SULF     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_OTHPT_SO4      $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    PSO4     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO4  255/1007     1   50
0 NEI11_OTHPT_C2H4     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ETH      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H4 254/1007     1   50
0 NEI11_OTHPT_C2H6     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ETHA     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H6 254/1007     1   50
0 NEI11_OTHPT_ALD2     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    ALD2     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ALD2 254/1007     1   50
0 NEI11_OTHPT_BCPI     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    PEC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  BCPI 256/1007/265 1   50
0 NEI11_OTHPT_BCPO     -                                                               -        -                       - -   -        BCPO 256/1007/266 1   50
0 NEI11_OTHPT_OCPI     $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_othpt.nc    POC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  OCPI 257/1007/267 1   50
0 NEI11_OTHPT_OCPO     -                                                               -        -                       - -   -        OCPO 257/1007/268 1   50

# NON-EGU INDUSTRIAL STACKS
0 NEI11_PTNONIPM_NO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc NO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO   251/1007     1   50
0 NEI11_PTNONIPM_NO2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc NO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NO2  251/1007     1   50
0 NEI11_PTNONIPM_HONO  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc HONO     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  HNO2 1007         1   50
0 NEI11_PTNONIPM_CO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc CO       2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CO   252/1007     1   50
0 NEI11_PTNONIPM_NH3   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc NH3      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  NH3  253/1007     1   50
0 NEI11_PTNONIPM_CH2O  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc FORM     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  CH2O 254/1007     1   50
0 NEI11_PTNONIPM_RCHO  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ALDX     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  RCHO 254/1007     1   50
#0 NEI11_PTNONIPM_MACR $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ACROLEIN 2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MACR 254/1007     1   50
0 NEI11_PTNONIPM_ACET  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc PAR      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ACET 254/1007/260 1   50
0 NEI11_PTNONIPM_C3H8  -                                                               -        -                       - -   -        C3H8 254/1007/261 1   50
0 NEI11_PTNONIPM_MEK   -                                                               -        -                       - -   -        MEK  254/1007/262 1   50
0 NEI11_PTNONIPM_ALK4  -                                                               -        -                       - -   -        ALK4 254/1007/263 1   50
0 NEI11_PTNONIPM_PRPE  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc OLE      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_PTNONIPM_PRP2  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc IOLE     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s PRPE 254/1007/264 1   50
0 NEI11_PTNONIPM_EOH   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ETOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  EOH  254/1007     1   50
0 NEI11_PTNONIPM_MOH   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc MEOH     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  MOH  254/1007     1   50
0 NEI11_PTNONIPM_XYLE  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc XYL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s XYLE 254/1007     1   50
0 NEI11_PTNONIPM_TOLU  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc TOL      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s TOLU 254/1007     1   50
0 NEI11_PTNONIPM_BENZ  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc BENZENE  2006-2013/1-12/1-31/$HH R xyz kgC/m2/s BENZ 254/1007     1   50
0 NEI11_PTNONIPM_SO2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc SO2      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_PTNONIPM_SULF  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc SULF     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO2  255/1007     1   50
0 NEI11_PTNONIPM_SO4   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc PSO4     2006-2013/1-12/1-31/$HH R xyz kg/m2/s  SO4  255/1007     1   50
0 NEI11_PTNONIPM_C2H4  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ETH      2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H4 254/1007     1   50
0 NEI11_PTNONIPM_C2H6  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ETHA     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s C2H6 254/1007     1   50
0 NEI11_PTNONIPM_ALD2  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc ALD2     2006-2013/1-12/1-31/$HH R xyz kgC/m2/s ALD2 254/1007     1   50
0 NEI11_PTNONIPM_BCPI  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc PEC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  BCPI 256/1007/265 1   50
0 NEI11_PTNONIPM_BCPO  -                                                               -        -                       - -   -        BCPO 256/1007/266 1   50
0 NEI11_PTNONIPM_OCPI  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_ptnonipm.nc POC      2006-2013/1-12/1-31/$HH R xyz kg/m2/s  OCPI 257/1007/267 1   50
0 NEI11_PTNONIPM_OCPO  -                                                               -        -                       - -   -        OCPO 257/1007/268 1   50
)))NEI2011

#==============================================================================
# --- STREETS SE ASIA (Zhang et al., 2009) ---
#==============================================================================
(((STREETS
0 ZHANG_NO__IND   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc NO_ind  2006/1/1/0 C xy kg/m2/s  NO   1/4/25/36/1003    1/2 40 
0 ZHANG_NO__POW   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc NO_pow  2006/1/1/0 C xy kg/m2/s  NO   1/4/25/36/1003    1/2 40 
0 ZHANG_NO__RES   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc NO_res  2006/1/1/0 C xy kg/m2/s  NO   1/4/25/36/1003    1/2 40 
0 ZHANG_NO__TRA   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc NO_tra  2006/1/1/0 C xy kg/m2/s  NO   1/4/25/36/1003    1/2 40 
0 ZHANG_CO__IND   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc CO_ind  2006/1/1/0 C xy kg/m2/s  CO   6/9/26/37/52/1003 1/2 40 
0 ZHANG_CO__POW   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc CO_pow  2006/1/1/0 C xy kg/m2/s  CO   6/9/26/37/52/1003 1/2 40 
0 ZHANG_CO__RES   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc CO_res  2006/1/1/0 C xy kg/m2/s  CO   6/9/26/37/52/1003 1/2 40 
0 ZHANG_CO__TRA   $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc CO_tra  2006/1/1/0 C xy kg/m2/s  CO   6/9/26/37/52/1003 1/2 40 
0 ZHANG_SO2__IND  $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc SO2_ind 2006/1/1/0 C xy kg/m2/s  SO2  11/14/1003        1/2 40 
0 ZHANG_SO4__IND  -                                                                 -       -          - -  -        SO4  11/14/63/1003     1/2 40 
0 ZHANG_SO2__POW  $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc SO2_pow 2006/1/1/0 C xy kg/m2/s  SO2  11/14/1003        1/2 40 
0 ZHANG_SO4__POW  -                                                                 -       -          - -  -        SO4  11/14/63/1003     1/2 40 
0 ZHANG_SO2__RES  $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc SO2_res 2006/1/1/0 C xy kg/m2/s  SO2  11/14/1003        1/2 40 
0 ZHANG_SO4__RES  -                                                                 -       -          - -  -        SO4  11/14/63/1003     1/2 40 
0 ZHANG_SO2__TRA  $ROOT/STREETS/v2014-07/2006/Streets_CO_NO_SO2_2006.generic.1x1.nc SO2_tra 2006/1/1/0 C xy kg/m2/s  SO2  11/14/1003        1/2 40 
0 ZHANG_SO4__TRA  -                                                                 -       -          - -  -        SO4  11/14/63/1003     1/2 40 
0 ZHANG_C2H6__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_dob     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40 
0 ZHANG_C2H6__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_dof     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40
0 ZHANG_C2H6__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_dop     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40
0 ZHANG_C2H6__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_ind     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40
0 ZHANG_C2H6__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_pow     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40
0 ZHANG_C2H6__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C2H6_tra     2006/1/1/0 C xy kgC/m2/s C2H6 26/1003           1/2 40
0 ZHANG_C3H8__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_dob     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_C3H8__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_dof     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_C3H8__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_dop     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_C3H8__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_ind     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_C3H8__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_pow     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_C3H8__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc C3H8_tra     2006/1/1/0 C xy kgC/m2/s C3H8 26/1003           1/2 40 
0 ZHANG_CH2O__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_dob     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_CH2O__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_dof     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_CH2O__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_dop     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_CH2O__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_ind     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_CH2O__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_pow     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_CH2O__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc CH2O_tra     2006/1/1/0 C xy kg/m2/s  CH2O 26/1003           1/2 40 
0 ZHANG_ALK4__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_dob     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ALK4__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_dof     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ALK4__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_dop     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ALK4__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_ind     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ALK4__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_pow     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ALK4__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALK4_tra     2006/1/1/0 C xy kgC/m2/s ALK4 26/1003           1/2 40 
0 ZHANG_ACET__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_dob     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_ACET__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_dof     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_ACET__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_dop     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_ACET__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_ind     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_ACET__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_pow     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_ACET__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ACET_tra     2006/1/1/0 C xy kgC/m2/s ACET 26/1003           1/2 40 
0 ZHANG_MEK__DOB  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_dob      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_MEK__DOF  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_dof      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_MEK__DOP  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_dop      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_MEK__IND  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_ind      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_MEK__POW  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_pow      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_MEK__TRA  $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc MEK_tra      2006/1/1/0 C xy kgC/m2/s MEK  26/1003           1/2 40 
0 ZHANG_ALD2__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_dob     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_ALD2__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_dof     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_ALD2__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_dop     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_ALD2__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_ind     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_ALD2__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_pow     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_ALD2__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc ALD2_tra     2006/1/1/0 C xy kgC/m2/s ALD2 26/1003           1/2 40 
0 ZHANG_PRPE__DOB $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_dob     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 
0 ZHANG_PRPE__DOF $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_dof     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 
0 ZHANG_PRPE__DOP $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_dop     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 
0 ZHANG_PRPE__IND $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_ind     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 
0 ZHANG_PRPE__POW $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_pow     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 
0 ZHANG_PRPE__TRA $ROOT/STREETS/v2014-07/2006/Streets_VOCs_2006.generic.1x1.nc PRPE_tra     2006/1/1/0 C xy kgC/m2/s PRPE 26/1003           1/2 40 

# --> NH3 emissions are only available for year 2000:
0 STREETS_NH3     $ROOT/STREETS/v2014-07/2000/Streets_2000.generic.1x1.nc      NH3_tot      2000/1/1/0 C xy kg/m2/s  NH3  38/1003           1/2 40 
)))STREETS

#==============================================================================
# --- MIX v1.1 (Asia) ---
#==============================================================================
(((MIX
0 MIX_NO_IND   $ROOT/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc   NO_INDUSTRY      2008-2010/1-12/1/0 C xy kg/m2/s  NO   1/27/25/1006  1/2 45
0 MIX_NO_POW   $ROOT/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc   NO_POWER         2008-2010/1-12/1/0 C xy kg/m2/s  NO   1/27/25/1006  1/2 45
0 MIX_NO_RES   $ROOT/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc   NO_RESIDENTIAL   2008-2010/1-12/1/0 C xy kg/m2/s  NO   1/27/25/1006  1/2 45
0 MIX_NO_TRA   $ROOT/MIX/v2015-03/MIX_Asia_NO.generic.025x025.nc   NO_TRANSPORT     2008-2010/1-12/1/0 C xy kg/m2/s  NO   1/27/25/1006  1/2 45
0 MIX_CO_IND   $ROOT/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc   CO_INDUSTRY      2008-2010/1-12/1/0 C xy kg/m2/s  CO   6/28/26/1006  1/2 45
0 MIX_CO_POW   $ROOT/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc   CO_POWER         2008-2010/1-12/1/0 C xy kg/m2/s  CO   6/28/26/1006  1/2 45
0 MIX_CO_RES   $ROOT/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc   CO_RESIDENTIAL   2008-2010/1-12/1/0 C xy kg/m2/s  CO   6/28/26/1006  1/2 45
0 MIX_CO_TRA   $ROOT/MIX/v2015-03/MIX_Asia_CO.generic.025x025.nc   CO_TRANSPORT     2008-2010/1-12/1/0 C xy kg/m2/s  CO   6/28/26/1006  1/2 45
0 MIX_SO2_IND  $ROOT/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc  SO2_INDUSTRY     2008-2010/1-12/1/0 C xy kg/m2/s  SO2  11/29/1006    1/2 45
0 MIX_SO4_IND  -                                                   -                -                  - -  -        SO4  11/29/63/1006 1/2 45
0 MIX_SO2_POW  $ROOT/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc  SO2_POWER        2008-2010/1-12/1/0 C xy kg/m2/s  SO2  11/29/1006    1/2 45
0 MIX_SO4_POW  -                                                   -                -                  - -  -        SO4  11/29/63/1006 1/2 45
0 MIX_SO2_RES  $ROOT/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc  SO2_RESIDENTIAL  2008-2010/1-12/1/0 C xy kg/m2/s  SO2  11/29/1006    1/2 45
0 MIX_SO4_RES  -                                                   -                -                  - -  -        SO4  11/29/63/1006 1/2 45
0 MIX_SO2_TRA  $ROOT/MIX/v2015-03/MIX_Asia_SO2.generic.025x025.nc  SO2_TRANSPORT    2008-2010/1-12/1/0 C xy kg/m2/s  SO2  11/29/1006    1/2 45
0 MIX_SO4_TRA  -                                                   -                -                  - -  -        SO4  11/29/63/1006 1/2 45
0 MIX_NH3_IND  $ROOT/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc  NH3_INDUSTRY     2008-2010/1-12/1/0 C xy kg/m2/s  NH3  1006          1/2 45
0 MIX_NH3_POW  $ROOT/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc  NH3_POWER        2008-2010/1-12/1/0 C xy kg/m2/s  NH3  1006          1/2 45
0 MIX_NH3_RES  $ROOT/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc  NH3_RESIDENTIAL  2008-2010/1-12/1/0 C xy kg/m2/s  NH3  1006          1/2 45
0 MIX_NH3_TRA  $ROOT/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc  NH3_TRANSPORT    2008-2010/1-12/1/0 C xy kg/m2/s  NH3  1006          1/2 45
0 MIX_NH3_AGR  $ROOT/MIX/v2015-03/MIX_Asia_NH3.generic.025x025.nc  NH3_AGRICULTURE  2008-2010/1-12/1/0 C xy kg/m2/s  NH3  1006          1/2 45
0 MIX_CH2O_IND $ROOT/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc CH2O_INDUSTRY    2008-2010/1-12/1/0 C xy kg/m2/s  CH2O 26/1006       1/2 45
0 MIX_CH2O_POW $ROOT/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc CH2O_POWER       2008-2010/1-12/1/0 C xy kg/m2/s  CH2O 26/1006       1/2 45
0 MIX_CH2O_RES $ROOT/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc CH2O_RESIDENTIAL 2008-2010/1-12/1/0 C xy kg/m2/s  CH2O 26/1006       1/2 45
0 MIX_CH2O_TRA $ROOT/MIX/v2015-03/MIX_Asia_CH2O.generic.025x025.nc CH2O_TRANSPORT   2008-2010/1-12/1/0 C xy kg/m2/s  CH2O 26/1006       1/2 45
0 MIX_C2H6_IND $ROOT/MIX/v2015-03/MIX_Asia_C2H6.generic.025x025.nc C2H6_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s C2H6 26/1006       1/2 45
0 MIX_C2H6_POW $ROOT/MIX/v2015-03/MIX_Asia_C2H6.generic.025x025.nc C2H6_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s C2H6 26/1006       1/2 45
0 MIX_C2H6_RES $ROOT/MIX/v2015-03/MIX_Asia_C2H6.generic.025x025.nc C2H6_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s C2H6 26/1006       1/2 45
0 MIX_C2H6_TRA $ROOT/MIX/v2015-03/MIX_Asia_C2H6.generic.025x025.nc C2H6_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s C2H6 26/1006       1/2 45
0 MIX_C3H8_IND $ROOT/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc C3H8_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s C3H8 26/1006       1/2 45
0 MIX_C3H8_POW $ROOT/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc C3H8_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s C3H8 26/1006       1/2 45
0 MIX_C3H8_RES $ROOT/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc C3H8_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s C3H8 26/1006       1/2 45
0 MIX_C3H8_TRA $ROOT/MIX/v2015-03/MIX_Asia_C3H8.generic.025x025.nc C3H8_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s C3H8 26/1006       1/2 45
0 MIX_ALK4_IND $ROOT/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc ALK4_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s ALK4 26/1006       1/2 45
0 MIX_ALK4_POW $ROOT/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc ALK4_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s ALK4 26/1006       1/2 45
0 MIX_ALK4_RES $ROOT/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc ALK4_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s ALK4 26/1006       1/2 45
0 MIX_ALK4_TRA $ROOT/MIX/v2015-03/MIX_Asia_ALK4.generic.025x025.nc ALK4_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s ALK4 26/1006       1/2 45
0 MIX_ACET_IND $ROOT/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc ACET_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s ACET 26/1006       1/2 45
0 MIX_ACET_POW $ROOT/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc ACET_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s ACET 26/1006       1/2 45
0 MIX_ACET_RES $ROOT/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc ACET_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s ACET 26/1006       1/2 45
0 MIX_ACET_TRA $ROOT/MIX/v2015-03/MIX_Asia_ACET.generic.025x025.nc ACET_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s ACET 26/1006       1/2 45
0 MIX_MEK_IND  $ROOT/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc  MEK_INDUSTRY     2008-2010/1-12/1/0 C xy kgC/m2/s MEK  26/1006       1/2 45
0 MIX_MEK_POW  $ROOT/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc  MEK_POWER        2008-2010/1-12/1/0 C xy kgC/m2/s MEK  26/1006       1/2 45
0 MIX_MEK_RES  $ROOT/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc  MEK_RESIDENTIAL  2008-2010/1-12/1/0 C xy kgC/m2/s MEK  26/1006       1/2 45
0 MIX_MEK_TRA  $ROOT/MIX/v2015-03/MIX_Asia_MEK.generic.025x025.nc  MEK_TRANSPORT    2008-2010/1-12/1/0 C xy kgC/m2/s MEK  26/1006       1/2 45
0 MIX_ALD2_IND $ROOT/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc ALD2_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s ALD2 26/1006       1/2 45
0 MIX_ALD2_POW $ROOT/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc ALD2_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s ALD2 26/1006       1/2 45
0 MIX_ALD2_RES $ROOT/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc ALD2_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s ALD2 26/1006       1/2 45
0 MIX_ALD2_TRA $ROOT/MIX/v2015-03/MIX_Asia_ALD2.generic.025x025.nc ALD2_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s ALD2 26/1006       1/2 45
0 MIX_PRPE_IND $ROOT/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc PRPE_INDUSTRY    2008-2010/1-12/1/0 C xy kgC/m2/s PRPE 26/1006       1/2 45
0 MIX_PRPE_POW $ROOT/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc PRPE_POWER       2008-2010/1-12/1/0 C xy kgC/m2/s PRPE 26/1006       1/2 45
0 MIX_PRPE_RES $ROOT/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc PRPE_RESIDENTIAL 2008-2010/1-12/1/0 C xy kgC/m2/s PRPE 26/1006       1/2 45
0 MIX_PRPE_TRA $ROOT/MIX/v2015-03/MIX_Asia_PRPE.generic.025x025.nc PRPE_TRANSPORT   2008-2010/1-12/1/0 C xy kgC/m2/s PRPE 26/1006       1/2 45
)))MIX

#==============================================================================
# --- Very-short-lived (VSL) bromocarbon emissions (cf. Qing Liang) ---
#==============================================================================
(((LIANG_BROMOCARB
0 LIANG_CHBR3  $ROOT/BROMINE/v2015-02/Bromocarb_Liang2010.nc CHBr3_emission  2000/1/1/0 C xy kg/m2/s CHBr3  39 1 1
0 LIANG_CH2BR2 $ROOT/BROMINE/v2015-02/Bromocarb_Liang2010.nc CH2Br2_emission 2000/1/1/0 C xy kg/m2/s CH2Br2 -  1 1
)))LIANG_BROMOCARB

#==============================================================================
# --- Ship emissions ---
#
# ==> In the defaults, ARCTAS SO2 has priority over ICOADS, CORBETT, and HTAP.
#     This can be ovewritten by EMEP over Europe.
# ==> For CO and NO, ICOADS has priority.
# ==> Do not use ship emissions from EDGAR v4.2 since they are lumped with
#     other non-road transportation (aircraft, rail, etc.) emissions
# ==> Ship NO emissions are used by PARANOx and the extension number must be
#     adjusted accordingly. If PARANOx is turned off, set the ExtNr back to
#     zero.
#==============================================================================
(((SHIP
0  ARCTAS_SHIP_SO2     $ROOT/ARCTAS_SHIP/v2014-07/ARCTAS_ship.generic.1x1.nc           SO2             2008/1/1/0             C xy kg/m2/s  SO2  11           10 1
#0 CORBETT_SHIP_SO2    $ROOT/CORBETT_SHIP/v2014-07/CORBETT_ship.geos.1x1.nc            SO2_SHIP        1985/1-12/1/0          C xy kg/m2/s  SO2  -            10 3
#0 ICOADS_SHIP_SO2     $ROOT/ICOADS_SHIP/v2014-07/ICOADS.generic.1x1.nc                SO2             2002/1-12/1/0          C xy kg/m2/s  SO2  11/15/60     10 5
#0 HTAP_SHIP_SO2       $ROOT/HTAP/v2015-03/EDGAR_HTAP_SO2_SHIPS.generic.01x01.nc       emi_so2         2008-2010/1/1/0        C xy kg/m2/s  SO2  11/29        10 2
0  ICOADS_SHIP_CO      $ROOT/ICOADS_SHIP/v2014-07/ICOADS.generic.1x1.nc                CO              2002/1-12/1/0          C xy kg/m2/s  CO   6/10         10 1
#0 HTAP_SHIP_CO        $ROOT/HTAP/v2015-03/EDGAR_HTAP_CO_SHIPS.generic.01x01.nc        emi_co          2008-2010/1/1/0        C xy kg/m2/s  CO   6/28         10 2

(((EMEP
0 EMEP_SHIP_CO         $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc                         ShipCO          1990-2012/1/1/0        C xy kg/m2/s  CO   1000         10 2
0 EMEP_SHIP_SO2        $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc                         ShipSO2         1990-2012/1/1/0        C xy kg/m2/s  SO2  61/1000      10 2
)))EMEP

(((NEI2011_SHIP
0 NEI11_C3MARINE_HONO  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc HONO            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  HNO2 1007         10 50
0 NEI11_C3MARINE_CO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc CO              2006-2013/$MM/$DD/0-23 R xy kg/m2/s  CO   252/1007     10 50
#0 NEI11_C3MARINE_NH3  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc NH3             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  NH3  253/1007     10 50
0 NEI11_C3MARINE_CH2O  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc FORM            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  CH2O 254/1007     10 50
0 NEI11_C3MARINE_RCHO  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ALDX            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  RCHO 254/1007     10 50
#0 NEI11_C3MARINE_MACR $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ACROLEIN        2006-2013/$MM/$DD/0-23 R xy kg/m2/s  MACR 254/1007     10 50
0 NEI11_C3MARINE_ACET  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc PAR             2006-2013/$MM/$DD/0-23 R xy kgC/m2/s ACET 254/1007/260 10 50
0 NEI11_C3MARINE_C3H8  -                                                               -               -                      - -  -        C3H8 254/1007/261 10 50
0 NEI11_C3MARINE_MEK   -                                                               -               -                      - -  -        MEK  254/1007/262 10 50
0 NEI11_C3MARINE_ALK4  -                                                               -               -                      - -  -        ALK4 254/1007/263 10 50
0 NEI11_C3MARINE_PRPE  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc OLE             2006-2013/$MM/$DD/0-23 R xy kgC/m2/s PRPE 254/1007/264 10 50
0 NEI11_C3MARINE_PRP2  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc IOLE            2006-2013/$MM/$DD/0-23 R xy kgC/m2/s PRPE 254/1007/265 10 50
0 NEI11_C3MARINE_EOH   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ETOH            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  EOH  254/1007     10 50
0 NEI11_C3MARINE_MOH   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc MEOH            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  MOH  254/1007     10 50
0 NEI11_C3MARINE_XYLE  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc XYL             2006-2013/$MM/$DD/0-23 R xy kgC/m2/s XYLE 254/1007     10 50
0 NEI11_C3MARINE_TOLU  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc TOL             2006-2013/$MM/$DD/0-23 R xy kgC/m2/s TOLU 254/1007     10 50
0 NEI11_C3MARINE_BENZ  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc BENZENE         2006-2013/$MM/$DD/0-23 R xy kgC/m2/s BENZ 254/1007     10 50
0 NEI11_C3MARINE_SO2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc SO2             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  SO2  255/1007     10 50
0 NEI11_C3MARINE_SULF  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc SULF            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  SO2  255/1007     10 50
0 NEI11_C3MARINE_SO4   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc PSO4            2006-2013/$MM/$DD/0-23 R xy kg/m2/s  SO4  255/1007     10 50
0 NEI11_C3MARINE_C2H4  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ETH             2006-2013/$MM/$DD/0-23 R xy kgC/m2/s C2H4 254/1007     10 50
0 NEI11_C3MARINE_C2H6  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ETHA            2006-2013/$MM/$DD/0-23 R xy kgC/m2/s C2H6 254/1007     10 50
0 NEI11_C3MARINE_ALD2  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc ALD2            2006-2013/$MM/$DD/0-23 R xy kgC/m2/s ALD2 254/1007     10 50
0 NEI11_C3MARINE_BCPI  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc PEC             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  BCPI 256/1007/265 10 50
0 NEI11_C3MARINE_BCPO  -                                                               -               -                      - -  -        BCPO 256/1007/266 10 50
0 NEI11_C3MARINE_OCPI  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc POC             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  OCPI 257/1007/267 10 50
0 NEI11_C3MARINE_OCPO  -                                                               -               -                      - -  -        OCPO 257/1007/268 10 50
)))NEI2011_SHIP

#------------------------------------------------------------------------------
# ### IF THE PARANOX EXTENSION IS TURNED ON ###
#
# Cosine(SZA) will be read from the restart file.  Use the PARANOX extension 
# number (# 102) to specify these quantities and the EMEP and NEI emissions.  
# This will make sure everything will be passed to the HEMCO PARANOX extension 
# rather than sending them into the base emissions.
#------------------------------------------------------------------------------
102  PARANOX_SUNCOS1   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                   PARANOX_SUNCOS1 $YYYY/$MM/$DD/$HH      C xy 1        *    -            1  1
102  PARANOX_SUNCOS2   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                   PARANOX_SUNCOS2 $YYYY/$MM/$DD/$HH      C xy 1        *    -            1  1
102  PARANOX_SUNCOS3   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                   PARANOX_SUNCOS3 $YYYY/$MM/$DD/$HH      C xy 1        *    -            1  1
102  PARANOX_SUNCOS4   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                   PARANOX_SUNCOS4 $YYYY/$MM/$DD/$HH      C xy 1        *    -            1  1
102  PARANOX_SUNCOS5   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                   PARANOX_SUNCOS5 $YYYY/$MM/$DD/$HH      C xy 1        *    -            1  1
102  ICOADS_SHIP_NO    $ROOT/ICOADS_SHIP/v2014-07/ICOADS.generic.1x1.nc                NO              2002/1-12/1/0          C xy kg/m2/s  NO   1/5          10 1
#102 HTAP_SHIP_NO      $ROOT/HTAP/v2015-03/EDGAR_HTAP_NO_SHIPS.generic.01x01.nc        emi_no          2008-2010/1/1/0        C xy kg/m2/s  NO   1/27         10 2

(((EMEP
102 EMEP_SHIP_NO       $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc                         ShipNO          1990-2012/1/1/0        C xy kg/m2/s  NO   1000         10 10
)))EMEP

(((NEI2011_SHIP
102 NEI11_C3MARINE_NO  $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc NO              2006-2013/$MM/$DD/0-23 R xy kg/m2/s  NO    251/1007    10 50
102 NEI11_C3MARINE_NO2 $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc NO2             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  NO2   251/1007    10 50
)))NEI2011_SHIP

#------------------------------------------------------------------------------
# ### IF THE PARANOX EXTENSION IS TURNED OFF ###
#
# Use extension # 0 to specify these emissions.  This will put them
# into the base emissions rather than sending them through PARANOX.
#------------------------------------------------------------------------------
(((.not.ParaNOx
0 ICOADS_SHIP_NO       $ROOT/ICOADS_SHIP/v2014-07/ICOADS.generic.1x1.nc                NO              2002/1-12/1/0          C xy kg/m2/s  NO    1/5         10 1
#0 HTAP_SHIP_NO        $ROOT/HTAP/v2015-03/EDGAR_HTAP_NO_SHIPS.generic.01x01.nc        emi_no          2008-2010/1/1/0        C xy kg/m2/s  NO    1/27        10 2

(((EMEP
0 EMEP_SHIP_NO         $ROOT/EMEP/v2015-03/EMEP.generic.1x1.nc                         ShipNO          1990-2012/1/1/0        C xy kg/m2/s  NO    1000        10 10
)))EMEP

(((NEI2011_SHIP
0 NEI11_C3MARINE_NO    $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc NO              2006-2013/$MM/$DD/0-23 R xy kg/m2/s  NO    251/1007    10 50
0 NEI11_C3MARINE_NO2   $ROOT/NEI2011/v2015-03/$MM/NEI11_0.1x0.1_2011$MM$DD_c3marine.nc NO2             2006-2013/$MM/$DD/0-23 R xy kg/m2/s  NO2   251/1007    10 50
)))NEI2011_SHIP

))).not.ParaNOx

)))SHIP
 
#==============================================================================
# --- BC/OC emissions from Tami Bond ---
#
# ==> Don't use biomass burning emissions if GFED extension is used!
# ==> Now emit all BC and OC as hydrophilic (tracers BCPI, OCPI).  Then we
#     apply factors to get the hydrophobic fraction (tracers BCPO, OCPO).
#==============================================================================
(((BOND
0 BOND_ANTH_BCPI $ROOT/BCOC_BOND/v2014-07/Bond_fossil.nc  BC   2000/1-12/1/0 C xy kg/m2/s BCPI 70 1 1
0 BOND_ANTH_BCPO -                                        -    -             - -  -       BCPO 71 1 1
0 BOND_ANTH_OCPI $ROOT/BCOC_BOND/v2014-07/Bond_fossil.nc  OC   2000/1-12/1/0 C xy kg/m2/s OCPI 72 1 1
0 BOND_ANTH_OCPO -                                        -    -             - -  -       OCPO 73 1 1
0 BOND_ANTH_POG1 -                                        -    -             - -  -       POG1 74 1 1
0 BOND_BF_BCPI   $ROOT/BCOC_BOND/v2014-07/Bond_biofuel.nc BC   2000/1-12/1/0 C xy kg/m2/s BCPI 70 2 1
0 BOND_BF_BCPO   -                                        -    -             - -  -       BCPO 71 2 1
0 BOND_BF_OCPI   $ROOT/BCOC_BOND/v2014-07/Bond_biofuel.nc OC   2000/1-12/1/0 C xy kg/m2/s OCPI 72 2 1
0 BOND_BF_OCPO   -                                        -    -             - -  -       OCPO 73 2 1
0 BOND_BF_POA1   -                                        -    -             - -  -       POA1 74 2 1

(((.not.GFED.or.FINN
0 BOND_BM_BCPI   $ROOT/BCOC_BOND/v2014-07/Bond_biomass.nc BC   2000/1-12/1/0 C xy kg/m2/s BCPI 70 2 1
0 BOND_BM_BCPO   -                                        -    -             - -  -       BCPO 71 2 1
0 BOND_BM_OCPI   $ROOT/BCOC_BOND/v2014-07/Bond_biomass.nc OC   2000/1-12/1/0 C xy kg/m2/s OCPI 72 2 1
0 BOND_BM_OCPO   -                                        -    -             - -  -       OCPO 73 2 1
0 BOND_BF_POA1   -                                        -    -             - -  -       POA1 74 2 1
))).not.GFED.or.FINN

)))BOND

#==============================================================================
# --- BC/OC emissions over NA from Cooke et al. (1999) ---
#
# ==> don't use in standard simulation
#==============================================================================
##0 COOKE_ANTH_BC $ROOT/BCOC_COOKE/v2014-07/BCOC_Cooke_fossil.gen.1x1.nc  BCPI 1998/1-12/1/0 C xy kg/m2/s BC 1004 1 2
##0 COOKE_ANTH_OC $ROOT/BCOC_COOKE/v2014-07/BCOC_Cooke_fossil.gen.1x1.nc  OCPI 1998/1-12/1/0 C xy kg/m2/s OC 1004 1 2
##0 COOKE_BF_BC   $ROOT/BCOC_COOKE/v2014-07/BCOC_Cooke_biofuel.gen.1x1.nc BCPI 1998/1-12/1/0 C xy kg/m2/s BC 1004 2 2
##0 COOKE_BF_OC   $ROOT/BCOC_COOKE/v2014-07/BCOC_Cooke_biofuel.gen.1x1.nc OCPI 1998/1-12/1/0 C xy kg/m2/s OC 1004 2 2

#==============================================================================
# --- AEIC aircraft emissions ---
#
# ==> Now emit aircraft BC and OC into hydrophilic tracers BCPI and OCPI.
#
# IMPORTANT NOTE: Set units attribute of HC variable to 'kg/m2/s'. This avoids
#                 any mass conversion by HEMCO.
#==============================================================================
(((AEIC
0 AEIC_NO   $ROOT/AEIC/v2015-01/AEIC.47L.gen.1x1.nc  NO2      2005/1-12/1/0 C xyz kg/m2/s NO   110/115 20 1
0 AEIC_CO   $ROOT/AEIC/v2015-01/AEIC.47L.gen.1x1.nc  CO       2005/1-12/1/0 C xyz kg/m2/s CO   110     20 1 
0 AEIC_SO2  $ROOT/AEIC/v2015-01/AEIC.47L.gen.1x1.nc  FUELBURN 2005/1-12/1/0 C xyz kg/m2/s SO2  111     20 1 
0 AEIC_SO4  -                                        -        -             - -   -       SO4  112     20 1 
0 AEIC_BCPI -                                        -        -             - -   -       BCPI 113     20 1 
0 AEIC_OCPI -                                        -        -             - -   -       OCPI 113     20 1 
0 AEIC_ACET $ROOT/AEIC/v2015-01/AEIC.47L.gen.1x1.nc  HC       2005/1-12/1/0 C xyz kg/m2/s ACET 114/101 20 1
0 AEIC_ALD2 -                                        -        -             - -   -       ALD2 114/102 20 1
0 AEIC_ALK4 -                                        -        -             - -   -       ALK4 114/103 20 1  
0 AEIC_C2H6 -                                        -        -             - -   -       C2H6 114/104 20 1
0 AEIC_C3H8 -                                        -        -             - -   -       C3H8 114/105 20 1
0 AEIC_CH2O -                                        -        -             - -   -       CH2O 114/106 20 1
0 AEIC_PRPE -                                        -        -             - -   -       PRPE 114/107 20 1 
0 AEIC_MACR -                                        -        -             - -   -       MACR 114/108 20 1
0 AEIC_RCHO -                                        -        -             - -   -       RCHO 114/109 20 1
)))AEIC

#==============================================================================
# --- Volcanic emissions ---
#==============================================================================
(((VOLCANO
0 VOLCANO_SO2_ERUPT $ROOT/VOLCANO/v2015-02/$YYYY/volc_so2_gen.1x1.47L.$YYYY$MM.nc SO2_erupt 1979-2009/1-12/1-31/0 C xyz kg/m2/s SO2 - 51 1
0 VOLCANO_SO2_DEGAS $ROOT/VOLCANO/v2015-02/$YYYY/volc_so2_gen.1x1.47L.$YYYY$MM.nc SO2_degas 1979-2009/1-12/1-31/0 C xyz kg/m2/s SO2 - 52 1
)))VOLCANO

#==============================================================================
# --- RCP future emissions scenarios ---
#==============================================================================
(((RCP_3PD
0 RCP3PD_CH4     $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_CH4_2005-2100_23474.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH4   -     1 1
0 RCP3PD_NOx     $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_NOx_2005-2100_23474.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NO    -     1 1
0 RCP3PD_CO      $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_CO_2005-2100_23474.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CO    -     1 1
0 RCP3PD_BCPO    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_BC_2005-2100_23474.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  BCPO  -     1 1
0 RCP3PD_OCPO    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_OC_2005-2100_23474.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  OCPO  -     1 1
0 RCP3PD_SO2     $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_SO2_2005-2100_23474.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  SO2   -     1 1
0 RCP3PD_NH3     $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_NH3_2005-2100_23474.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NH3   -     1 1
0 RCP3PD_C2H2    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_acetylene_2005-2100_23474_kgC.nc                  ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H2  -     1 1
0 RCP3PD_CH2O    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_formaldehyde_2005-2100_23474.nc                   ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH2O  -     1 1
0 RCP3PD_BENZ    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_benzene_2005-2100_23474_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s BENZ  -     1 1
0 RCP3PD_TOLU    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_toluene_2005-2100_23474_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s TOLU  -     1 1
0 RCP3PD_XYLE    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_xylene_2005-2100_23474_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s XYLE  -     1 1
0 RCP3PD_ALD2    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_other_aldehydes_2005-2100_23474_kgC.nc            ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALD2  -     1 1
0 RCP3PD_ALK4__A $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_butanes_2005-2100_23474_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP3PD_ALK4__B $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_pentanes_2005-2100_23474_kgC.nc                   ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP3PD_ALK4__C $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_hexanes_and_higher_alkanes_2005-2100_23474_kgC.nc ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP3PD_ACET    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_total_ketones_2005-2100_23474_kgC.nc              ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ACET  51    1 1
0 RCP3PD_MEK     -                                                                                        -      -               - -  -        MEK   50    1 1
0 RCP3PD_C2H6    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_ethane_2005-2100_23474_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H6  -     1 1
0 RCP3PD_C2H4    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_ethene_2005-2100_23474_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H4  -     1 1
0 RCP3PD_C3H8    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_propane_2005-2100_23474_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C3H8  -     1 1
0 RCP3PD_PRPE    $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_propene_2005-2100_23474_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s PRPE  -     1 1
0 RCP3PD_HCOOH   $ROOT/RCP/v2015-02/RCP_3PD/RCPs_anthro_total_acids_2005-2100_23474.nc                    ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  HCOOH 57/58 1 1
)))RCP_3PD

(((RCP_45 
0 RCP45_CH4     $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_CH4_2005-2100_27424.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH4   -     1 1
0 RCP45_NOx     $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_NOx_2005-2100_27424.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NO    -     1 1
0 RCP45_CO      $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_CO_2005-2100_27424.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CO    -     1 1
0 RCP45_BCPO    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_BC_2005-2100_27424.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  BCPO  -     1 1
0 RCP45_OCPO    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_OC_2005-2100_27424.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  OCPO  -     1 1
0 RCP45_SO2     $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_SO2_2005-2100_27424.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  SO2   -     1 1
0 RCP45_NH3     $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_NH3_2005-2100_27424.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NH3   -     1 1
0 RCP45_C2H2    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_acetylene_2005-2100_27424_kgC.nc                  ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H2  -     1 1
0 RCP45_CH2O    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_formaldehyde_2005-2100_27424.nc                   ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH2O  -     1 1
0 RCP45_BENZ    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_benzene_2005-2100_27424_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s BENZ  -     1 1
0 RCP45_TOLU    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_toluene_2005-2100_27424_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s TOLU  -     1 1
0 RCP45_XYLE    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_xylene_2005-2100_27424_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s XYLE  -     1 1
0 RCP45_ALD2    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_other_aldehydes_2005-2100_27424_kgC.nc            ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALD2  -     1 1
0 RCP45_ALK4__A $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_butanes_2005-2100_27424_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP45_ALK4__B $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_pentanes_2005-2100_27424_kgC.nc                   ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP45_ALK4__C $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_hexanes_and_higher_alkanes_2005-2100_27424_kgC.nc ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP45_ACET    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_total_ketones_2005-2100_27424_kgC.nc              ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ACET  51    1 1
0 RCP45_MEK     -                                                                                       -      -               - -  -        MEK   50    1 1
0 RCP45_C2H6    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_ethane_2005-2100_27424_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H6  -     1 1
0 RCP45_C2H4    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_ethene_2005-2100_27424_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H4  -     1 1
0 RCP45_C3H8    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_propane_2005-2100_27424_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C3H8  -     1 1
0 RCP45_PRPE    $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_propene_2005-2100_27424_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s PRPE  -     1 1
0 RCP45_HCOOH   $ROOT/RCP/v2015-02/RCP_45/RCPs_anthro_total_acids_2005-2100_27424.nc                    ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  HCOOH 57/58 1 1
)))RCP_45

(((RCP_60 
0 RCP60_CH4     $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_CH4_2005-2100_43190.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH4   -     1 1
0 RCP60_NOx     $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_NOx_2005-2100_43190.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NO    -     1 1
0 RCP60_CO      $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_CO_2005-2100_43190.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CO    -     1 1
0 RCP60_BCPO    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_BC_2005-2100_43190.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  BCPO  -     1 1
0 RCP60_OCPO    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_OC_2005-2100_43190.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  OCPO  -     1 1
0 RCP60_SO2     $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_SO2_2005-2100_43190.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  SO2   -     1 1
0 RCP60_NH3     $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_NH3_2005-2100_43190.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NH3   -     1 1
0 RCP60_C2H2    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_acetylene_2005-2100_43190_kgC.nc                  ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H2  -     1 1
0 RCP60_CH2O    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_formaldehyde_2005-2100_43190.nc                   ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH2O  -     1 1
0 RCP60_BENZ    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_benzene_2005-2100_43190_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s BENZ  -     1 1
0 RCP60_TOLU    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_toluene_2005-2100_43190_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s TOLU  -     1 1
0 RCP60_XYLE    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_xylene_2005-2100_43190_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s XYLE  -     1 1
0 RCP60_ALD2    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_other_aldehydes_2005-2100_43190_kgC.nc            ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALD2  -     1 1
0 RCP60_ALK4__A $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_butanes_2005-2100_43190_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP60_ALK4__B $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_pentanes_2005-2100_43190_kgC.nc                   ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP60_ALK4__C $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_hexanes_and_higher_alkanes_2005-2100_43190_kgC.nc ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP60_ACET    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_total_ketones_2005-2100_43190_kgC.nc              ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ACET  51    1 1
0 RCP60_MEK     -                                                                                       -      -               - -  -        MEK   50    1 1
0 RCP60_C2H6    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_ethane_2005-2100_43190_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H6  -     1 1
0 RCP60_C2H4    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_ethene_2005-2100_43190_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H4  -     1 1
0 RCP60_C3H8    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_propane_2005-2100_43190_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C3H8  -     1 1
0 RCP60_PRPE    $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_propene_2005-2100_43190_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s PRPE  -     1 1
0 RCP60_HCOOH   $ROOT/RCP/v2015-02/RCP_60/RCPs_anthro_total_acids_2005-2100_43190.nc                    ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  HCOOH 57/58 1 1
)))RCP_60

(((RCP_85 
0 RCP85_CH4     $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_CH4_2005-2100_43533.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH4   -     1 1
0 RCP85_NOx     $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_NOx_2005-2100_43533.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NO    -     1 1
0 RCP85_CO      $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_CO_2005-2100_43533.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CO    -     1 1
0 RCP85_BCPO    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_BC_2005-2100_43533.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  BCPO  -     1 1
0 RCP85_OCPO    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_OC_2005-2100_43533.nc                             ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  OCPO  -     1 1
0 RCP85_SO2     $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_SO2_2005-2100_43533.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  SO2   -     1 1
0 RCP85_NH3     $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_NH3_2005-2100_43533.nc                            ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  NH3   -     1 1
0 RCP85_C2H2    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_acetylene_2005-2100_43533_kgC.nc                  ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H2  -     1 1
0 RCP85_CH2O    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_formaldehyde_2005-2100_43533.nc                   ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  CH2O  -     1 1
0 RCP85_BENZ    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_benzene_2005-2100_43533_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s BENZ  -     1 1
0 RCP85_TOLU    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_toluene_2005-2100_43533_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s TOLU  -     1 1
0 RCP85_XYLE    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_xylene_2005-2100_43533_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s XYLE  -     1 1
0 RCP85_ALD2    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_other_aldehydes_2005-2100_43533_kgC.nc            ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALD2  -     1 1
0 RCP85_ALK4__A $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_butanes_2005-2100_43533_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP85_ALK4__B $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_pentanes_2005-2100_43533_kgC.nc                   ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP85_ALK4__C $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_hexanes_and_higher_alkanes_2005-2100_43533_kgC.nc ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ALK4  -     1 1
0 RCP85_ACET    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_total_ketones_2005-2100_43533_kgC.nc              ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s ACET  51    1 1
0 RCP85_MEK     -                                                                                       -      -               - -  -        MEK   50    1 1
0 RCP85_C2H6    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_ethane_2005-2100_43533_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H6  -     1 1
0 RCP85_C2H4    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_ethene_2005-2100_43533_kgC.nc                     ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C2H4  -     1 1
0 RCP85_C3H8    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_propane_2005-2100_43533_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s C3H8  -     1 1
0 RCP85_PRPE    $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_propene_2005-2100_43533_kgC.nc                    ACCMIP 2005-2100/1/1/0 I xy kgC/m2/s PRPE  -     1 1
0 RCP85_HCOOH   $ROOT/RCP/v2015-02/RCP_85/RCPs_anthro_total_acids_2005-2100_43533.nc                    ACCMIP 2005-2100/1/1/0 I xy kg/m2/s  HCOOH 57/58 1 1
)))RCP_85

###############################################################################
### EXTENSION DATA (subsection of BASE EMISSIONS SECTION)
###
### These fields are needed by the extensions listed above. The assigned ExtNr 
### must match the ExtNr entry in section 'Extension switches'. These fields 
### are only read if the extension is enabled.  The fields are imported by the
### extensions by field name.  The name given here must match the name used 
### in the extension's source code. 
###############################################################################

#==============================================================================
# --- Seawater concentrations for oceanic emissions (Extension 101) ---
#==============================================================================
#101 CH3I_SEAWATER  $ROOT/CH3I/v2014-07/ocean_ch3i.geos.4x5.nc       CH3I       1985/1-12/1/0 C xy kg/m3 CH3I - 1 1
101 DMS_SEAWATER    $ROOT/DMS/v2014-07/DMS_seawater.geos.1x1.nc      DMS_OCEAN  1985/1-12/1/0 C xy kg/m3 DMS  - 1 1
101 ACET_SEAWATER   $ROOT/ACET/v2014-07/ACET_seawater.generic.1x1.nc ACET       2005/1/1/0    C xy kg/m3 ACET - 1 1 

#==============================================================================
# --- LIGHTNOX emissions (Extension 103) ---
#
# Local redistribution factors: These are model-specific and hence need to be 
# redefined for different model/resolution simulations!!!
#==============================================================================
103 LIGHTNOX_OTDLIS $ROOT/LIGHTNOX/v2014-07/OTD-LIS-Local-Redist.CTH.v5.{LNOX}.$RES.CH.nc OTD $YYYY/1-12/1/0 C xy unitless NO - 1 1

#==============================================================================
# --- SOILNOX emissions (Extension 104) ---
#==============================================================================
104 PFACTOR         ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                 PFACTOR       $YYYY/$MM/$DD/$HH C xy 1     NO - 1 1
104 DRYPERIOD       ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                 DRYPERIOD     $YYYY/$MM/$DD/$HH C xy 1     NO - 1 1
104 GWET_PREV       ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                 GWET_PREV     $YYYY/$MM/$DD/$HH C xy 1     NO - 1 1
104 DEP_RESERVOIR   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc                 DEP_RESERVOIR $YYYY/$MM/$DD/$HH C xy kg/m3 NO - 1 1
104 SOILNOX_FERT    $ROOT/SOILNOX/v2014-07/soilNOx.fert_res.generic.05x05.nc      FERT          2000/1-12/1-31/0  C xy kg/m3 NO - 1 1
104 SOILNOX_LANDK1  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K01  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK2  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K02  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK3  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K03  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK4  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K04  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK5  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K05  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK6  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K06  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK7  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K07  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK8  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K08  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK9  $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K09  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK10 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K10  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK11 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K11  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK12 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K12  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK13 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K13  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK14 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K14  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK15 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K15  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK16 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K16  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK17 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K17  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK18 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K18  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK19 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K19  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK20 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K20  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK21 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K21  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK22 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K22  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK23 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K23  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_LANDK24 $ROOT/SOILNOX/v2014-07/soilNOx.landtype.generic.025x025.1L.nc LANDFRAC_K24  2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_ARID    $ROOT/SOILNOX/v2014-07/soilNOx.climate.generic.05x05.nc       ARID          2000/1/1/0        C xy 1     NO - 1 1
104 SOILNOX_NONARID $ROOT/SOILNOX/v2014-07/soilNOx.climate.generic.05x05.nc       NON_ARID      2000/1/1/0        C xy 1     NO - 1 1

#==============================================================================
# --- dust emissions using DEAD model (Extension 105) ---
#==============================================================================
105 DEAD_EF_GEO   $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     EF_GEO   1985/1/1/0    C xy factor   * - 1 1
105 DEAD_LF_DRY   $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     LF_DRY   1985/1/1/0    C xy factor   * - 1 1
105 DEAD_MF_CACO3 $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     MF_CaCO3 1985/1/1/0    C xy fraction * - 1 1
105 DEAD_MF_CLY   $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     MF_CLY   1985/1/1/0    C xy fraction * - 1 1
105 DEAD_MF_SND   $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     MF_SND   1985/1/1/0    C xy fraction * - 1 1
105 DEAD_SFC_TYP  $ROOT/DUST_DEAD/v2014-07/dst_tibds.geos.4x5.nc     SFC_TYP  1985/1/1/0    C xy unitless * - 1 1
105 DEAD_GOC_SRC  $ROOT/DUST_DEAD/v2014-07/GOCART_src_fn.geos.4x5.nc GOC_SRC  1985/1/1/0    C xy unitless * - 1 1
105 DEAD_VAI      $ROOT/DUST_DEAD/v2014-07/dst_tvbds.geos.4x5.nc     VAI      1985/1-12/1/0 C xy unitless * - 1 1

#==============================================================================
# --- Dust emissions using Paul Ginoux's mechanism (Extension 106) 
#==============================================================================
106 GINOUX_SAND   $ROOT/DUST_GINOUX/v2014-07/NSP.dust.geos.4x5.nc  SAND  1985/1/1/0 C xy unitless * - 1 1 
106 GINOUX_SILT   $ROOT/DUST_GINOUX/v2014-07/NSP.dust.geos.4x5.nc  SILT  1985/1/1/0 C xy unitless * - 1 1 
106 GINOUX_CLAY   $ROOT/DUST_GINOUX/v2014-07/NSP.dust.geos.4x5.nc  CLAY  1985/1/1/0 C xy unitless * - 1 1 

#==============================================================================
# --- Sea salt emissions (Extension 107) 
#==============================================================================
# --- No external data --- 

#==============================================================================
# --- MEGAN biogenic emissions (Extension 108)
#
# NOTE: These are the base emissions, which will be converted to kgC/m2/s by 
# HEMCO. The specified species (OCPI/ISOP/ACET) are required for proper unit 
# conversion. Since netCDF files are already in mass carbon (ug(C)), the only 
# important thing is to specify a VOC with a specified MW of 12g/mol. 
# This is the case for OCPI, ISOP and ACET.
#
# We don't need to read EF maps for acetone, a-pinene or myrcene. We now
# compute those values in the MEGAN extension.
#==============================================================================
108  T_DAVG                       ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc T_DAVG                  $YYYY/$MM/$DD/$HH C xy K        * - 1 1
108  T_PREVDAY                    ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc T_PREVDAY               $YYYY/$MM/$DD/$HH C xy K        * - 1 1
108  LAI_PREVDAY                  ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc LAI_PREVDAY             $YYYY/$MM/$DD/$HH C xy 1        * - 1 1
108  PARDR_DAVG                   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc PARDR_DAVG              $YYYY/$MM/$DD/$HH C xy W/m2     * - 1 1
108  PARDF_DAVG                   ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc PARDF_DAVG              $YYYY/$MM/$DD/$HH C xy W/m2     * - 1 1
108  MEGAN_AEF_ISOP               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_ISOPRENE            1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_MBOX               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_MBO                 1985/1/1/0        C xy kgC/m2/s * - 1 1
#109 MEGAN_AEF_APIN               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_ALPHA_PINENE        1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_BPIN               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_BETA_PINENE         1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_CARE               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_CARENE              1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_LIMO               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_LIMONENE            1985/1/1/0        C xy kgC/m2/s * - 1 1
#109 MEGAN_AEF_MYRC               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_MYRCENE             1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_OCIM               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_OCIMENE             1985/1/1/0        C xy kgC/m2/s * - 1 1
109  MEGAN_AEF_SABI               $ROOT/MEGAN/v2015-02/MEGAN2.1_EF.geos.1x1.nc  AEF_SABINENE            1985/1/1/0        C xy kgC/m2/s * - 1 1
108  CLM4_PFT_BARE                $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BARE                2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_NDLF_EVGN_TMPT_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_NDLF_EVGN_TMPT_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_NDLF_EVGN_BORL_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_NDLF_EVGN_BORL_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_NDLF_DECD_BORL_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_NDLF_DECD_BORL_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_EVGN_TROP_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_EVGN_TROP_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_EVGN_TMPT_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_EVGN_TMPT_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_DECD_TROP_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_DECD_TROP_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_DECD_TMPT_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_DECD_TMPT_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_DECD_BORL_TREE $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_DECD_BORL_TREE 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_EVGN_SHRB      $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_EVGN_SHRB      2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_DECD_TMPT_SHRB $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_DECD_TMPT_SHRB 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_BDLF_DECD_BORL_SHRB $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_BDLF_DECD_BORL_SHRB 2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_C3_ARCT_GRSS        $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_C3_ARCT_GRSS        2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_C3_NARC_GRSS        $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_C3_NARC_GRSS        2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_C4_GRSS             $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_C4_GRSS             2000/1/1/0        C xy 1        * - 1 1
108  CLM4_PFT_CROP                $ROOT/MEGAN/v2015-02/CLM4_PFT.geos.1x1.nc     PFT_CROP                2000/1/1/0        C xy 1        * - 1 1
110  MEGAN_ORVC                   $ROOT/SOA/v2014-07/NVOC.geos.1x1.nc           OCPI                    1990/1-12/1/0     C xy kgC/m2/s * - 1 1

#==============================================================================
# --- GFED biomass burning emissions (Extension 111) 
# NOTE: These are the base emissions in kgDM/m2/s.
#==============================================================================
111 GFED_HUMTROP    $ROOT/GFED3/v2014-10/GFED3_humtropmap.nc              humtrop           2000/1/1/0             C xy unitless  * - 1 1

(((GFED3   
111 GFED_WDL        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__WDL_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
111 GFED_AGW        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__AGW_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
111 GFED_DEF        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__DEF_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
111 GFED_FOR        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__FOR_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
111 GFED_PET        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__PET_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
111 GFED_SAV        $ROOT/GFED3/v2014-10/GFED3_gen.1x1.$YYYY.nc           GFED3_BB__SAV_DM  1997-2011/1-12/01/0    C xy kgDM/m2/s * - 1 1
)))GFED3  

(((GFED4
111 GFED_WDL        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       WDL_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
111 GFED_AGW        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       AGW_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
111 GFED_DEF        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       DEF_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
111 GFED_FOR        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       FOR_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
111 GFED_PET        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       PET_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
111 GFED_SAV        $ROOT/GFED4/v2015-03/GFED4_gen.025x025.$YYYY.nc       SAV_DM            2000-2013/1-12/01/0    C xy kg/m2/s   * - 1 1
)))GFED4

(((GFED_daily
111 GFED_FRAC_DAY   $ROOT/GFED3/v2014-10/GFED3_dailyfrac_gen.1x1.$YYYY.nc GFED3_BB__DAYFRAC 2002-2011/1-12/1-31/0  R xy unitless  * - 1 1
)))GFED_daily

(((GFED_3hourly
111 GFED_FRAC_3HOUR $ROOT/GFED3/v2014-10/GFED3_3hrfrac_gen.1x1.$YYYY.nc   GFED3_BB__HRFRAC  2002-2011/1-12/01/0-23 R xy unitless  * - 1 1
)))GFED_3hourly

#==============================================================================
# --- FINN biomass burning emissions (Extension 114) 
#==============================================================================
(((.not.FINN_daily
114 FINN_VEGTYP1       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype1 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
114 FINN_VEGTYP2       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype2 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
114 FINN_VEGTYP3       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype3 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
114 FINN_VEGTYP4       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype4 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
114 FINN_VEGTYP5       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype5 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
114 FINN_VEGTYP9       $ROOT/FINN/v2014-07/FINN_monthly_05x05.nc fire_vegtype9 2007-2013/1-12/1/0    C xy kg/m2/s * - 1 1
))).not.FINN_daily

(((FINN_daily
114 FINN_DAILY_VEGTYP1 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype1 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
114 FINN_DAILY_VEGTYP2 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype2 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
114 FINN_DAILY_VEGTYP3 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype3 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
114 FINN_DAILY_VEGTYP4 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype4 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
114 FINN_DAILY_VEGTYP5 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype5 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
114 FINN_DAILY_VEGTYP9 $ROOT/FINN/v2014-07/FINN_daily_05x05.nc   fire_vegtype9 2007-2013/1-12/1-31/0 C xy kg/m2/s * - 1 1
)))FINN_daily

###############################################################################
### NON-EMISSIONS DATA (subsection of BASE EMISSIONS SECTION)
###
### Non-emissions data. The following fields are read through HEMCO but do 
### not contain emissions data. The extension number is set to wildcard 
### character denoting that these fields will not be considered for emission 
### calculation. A given entry is only read if the assigned species name is 
### an HEMCO species.
###############################################################################

#==============================================================================
# --- Time zones (offset to UTC) ---
#==============================================================================
* TIMEZONES $ROOT/TIMEZONES/v2015-02/timezones_1x1.nc UTC_OFFSET 2000/1/1/0 C xy count * - 1 1

#==============================================================================
# --- UV albedo, for photolysis (cf Hermann & Celarier, 1997) ---
#==============================================================================
(((+UValbedo+
* UV_ALBEDO $ROOT/UVALBEDO/v2015-03/uvalbedo.geos.2x25.nc UVALBD 1985/1-12/1/0 C xy 1 * - 1 1
)))+UValbedo+

#==============================================================================
# --- TOMS/SBUV overhead ozone colums, for photolysis ---
#==============================================================================
(((+TOMS_SBUV_O3+
* TOMS_O3_COL   $ROOT/TOMS_SBUV/v2015-03/TOMS_O3col_$YYYY.geos.1x1.nc TOMS   1971-2010/1-12/1/0 C xy dobsons     * - 1 1
* DTOMS1_O3_COL -                                                     DTOMS1 -                  - -  dobsons/day * - 1 1 
* DTOMS2_O3_COL -                                                     DTOMS2 -                  - -  dobsons/day * - 1 1
)))+TOMS_SBUV_O3+

#==============================================================================
# --- PSC state, only needed for UCX ---
#==============================================================================
(((+STATE_PSC+
* STATE_PSC  ./initial_hemco_rst.$MET_$RES_{SIM}_{NEST}.nc STATE_PSC $YYYY/$MM/$DD/$HH C xyz count * - 1 1
)))+STATE_PSC+

#==============================================================================
# --- Linear stratospheric chemistry fields ---
#
# These fields will only be read if the +LinStratChem+ toggle is activated.
# +LinStratChem+ can be set explicitly above as a setting of the base
# extension (--> +LinStratChem+: true/false). If not defined, it will be set
# automatically based on the linear stratospheric chemistry toggle in
# input.geos (recommended).
#==============================================================================
(((+LinStratChem+

#------------------------------------------------------------------------------
# --- Stratospheric Bry data from the CCM model  ---
#------------------------------------------------------------------------------
* GEOSCCM_Br_DAY      $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   BR     2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_Br2_DAY     $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   BRCL   2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_BrO_DAY     $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   BRO    2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_BrNO3_DAY   $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   BRONO2 2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_HBr_DAY     $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   HBR    2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_HOBr_DAY    $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.day.nc   HOBR   2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_Br_NIGHT    $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc BR     2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_Br2_NIGHT   $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc BRCL   2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_BrO_NIGHT   $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc BRO    2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_BrNO3_NIGHT $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc BRONO2 2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_HBr_NIGHT   $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc HBR    2007/$MM/1/0 C xyz pptv * - 60 1
* GEOSCCM_HOBr_NIGHT  $ROOT/STRAT/v2015-01/Bry/GEOSCCM_Bry.2007$MM.night.nc HOBR   2007/$MM/1/0 C xyz pptv * - 60 1

#------------------------------------------------------------------------------
#--- GMI chemistry: prod/loss rates (for strato-/mesosphere) ---
#------------------------------------------------------------------------------
* GMI_LOSS_A3O2       $ROOT/GMI/v2015-02/gmi.clim.A3O2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   A3O2     - 1  1
* GMI_PROD_A3O2       $ROOT/GMI/v2015-02/gmi.clim.A3O2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s A3O2     - 1  1
* GMI_LOSS_ACET       $ROOT/GMI/v2015-02/gmi.clim.ACET.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ACET     - 1  1
* GMI_PROD_ACET       $ROOT/GMI/v2015-02/gmi.clim.ACET.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ACET     - 1  1
* GMI_LOSS_ACTA       $ROOT/GMI/v2015-02/gmi.clim.ACTA.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ACTA     - 1  1
* GMI_PROD_ACTA       $ROOT/GMI/v2015-02/gmi.clim.ACTA.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ACTA     - 1  1
* GMI_LOSS_ALD2       $ROOT/GMI/v2015-02/gmi.clim.ALD2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ALD2     - 1  1
* GMI_PROD_ALD2       $ROOT/GMI/v2015-02/gmi.clim.ALD2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ALD2     - 1  1
* GMI_LOSS_ALK4       $ROOT/GMI/v2015-02/gmi.clim.ALK4.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ALK4     - 1  1
* GMI_PROD_ALK4       $ROOT/GMI/v2015-02/gmi.clim.ALK4.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ALK4     - 1  1
* GMI_LOSS_ATO2       $ROOT/GMI/v2015-02/gmi.clim.ATO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ATO2     - 1  1
* GMI_PROD_ATO2       $ROOT/GMI/v2015-02/gmi.clim.ATO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ATO2     - 1  1
* GMI_LOSS_B3O2       $ROOT/GMI/v2015-02/gmi.clim.B3O2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   B3O2     - 1  1
* GMI_PROD_B3O2       $ROOT/GMI/v2015-02/gmi.clim.B3O2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s B3O2     - 1  1
#* GMI_LOSS_Br        $ROOT/GMI/v2015-02/gmi.clim.Br.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   Br       - 1  1
#* GMI_PROD_Br        $ROOT/GMI/v2015-02/gmi.clim.Br.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s Br       - 1  1
#* GMI_LOSS_BrCl      $ROOT/GMI/v2015-02/gmi.clim.BrCl.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   BrCl     - 1  1
#* GMI_PROD_BrCl      $ROOT/GMI/v2015-02/gmi.clim.BrCl.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s BrCl     - 1  1
#* GMI_LOSS_BrO       $ROOT/GMI/v2015-02/gmi.clim.BrO.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   BrO      - 1  1
#* GMI_PROD_BrO       $ROOT/GMI/v2015-02/gmi.clim.BrO.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s BrO      - 1  1
#* GMI_LOSS_BrNO3     $ROOT/GMI/v2015-02/gmi.clim.BrONO2.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   BrNO3    - 1  1
#* GMI_PROD_BrNO3     $ROOT/GMI/v2015-02/gmi.clim.BrONO2.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s BrNO3    - 1  1
* GMI_LOSS_C2H6       $ROOT/GMI/v2015-02/gmi.clim.C2H6.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   C2H6     - 1  1
* GMI_PROD_C2H6       $ROOT/GMI/v2015-02/gmi.clim.C2H6.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s C2H6     - 1  1
* GMI_LOSS_C3H8       $ROOT/GMI/v2015-02/gmi.clim.C3H8.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   C3H8     - 1  1
* GMI_PROD_C3H8       $ROOT/GMI/v2015-02/gmi.clim.C3H8.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s C3H8     - 1  1
* GMI_LOSS_CCl4       $ROOT/GMI/v2015-02/gmi.clim.CCl4.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   CCl4     - 1  1
* GMI_PROD_CCl4       $ROOT/GMI/v2015-02/gmi.clim.CCl4.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s CCl4     - 1  1
#* GMI_LOSS_H1202     $ROOT/GMI/v2015-02/gmi.clim.CF2Br2.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   H1202    - 1  1
#* GMI_PROD_H1202     $ROOT/GMI/v2015-02/gmi.clim.CF2Br2.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s H1202    - 1  1
* GMI_LOSS_CFC12      $ROOT/GMI/v2015-02/gmi.clim.CF2Cl2.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   CFC12    - 1  1
* GMI_PROD_CFC12      $ROOT/GMI/v2015-02/gmi.clim.CF2Cl2.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s CFC12    - 1  1
* GMI_LOSS_H1211      $ROOT/GMI/v2015-02/gmi.clim.CF2ClBr.geos5.2x25.nc     loss    2000/$MM/1/0 C xyz s-1   H1211    - 1  1
* GMI_PROD_H1211      $ROOT/GMI/v2015-02/gmi.clim.CF2ClBr.geos5.2x25.nc     prod    2000/$MM/1/0 C xyz v/v/s H1211    - 1  1
#* GMI_LOSS_H1311     $ROOT/GMI/v2015-02/gmi.clim.CF3Br.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   H1311    - 1  1
#* GMI_PROD_H1311     $ROOT/GMI/v2015-02/gmi.clim.CF3Br.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s H1311    - 1  1
* GMI_LOSS_CFC113     $ROOT/GMI/v2015-02/gmi.clim.CFC113.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   CFC113   - 1  1
* GMI_PROD_CFC113     $ROOT/GMI/v2015-02/gmi.clim.CFC113.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s CFC113   - 1  1
* GMI_LOSS_CFC114     $ROOT/GMI/v2015-02/gmi.clim.CFC114.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   CFC114   - 1  1
* GMI_PROD_CFC114     $ROOT/GMI/v2015-02/gmi.clim.CFC114.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s CFC114   - 1  1
* GMI_LOSS_CFC115     $ROOT/GMI/v2015-02/gmi.clim.CFC115.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   CFC115   - 1  1
* GMI_PROD_CFC115     $ROOT/GMI/v2015-02/gmi.clim.CFC115.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s CFC115   - 1  1
* GMI_LOSS_CFC11      $ROOT/GMI/v2015-02/gmi.clim.CFCl3.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   CFC11    - 1  1
* GMI_PROD_CFC11      $ROOT/GMI/v2015-02/gmi.clim.CFCl3.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s CFC11    - 1  1
* GMI_LOSS_CH2O       $ROOT/GMI/v2015-02/gmi.clim.CH2O.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   CH2O     - 1  1
* GMI_PROD_CH2O       $ROOT/GMI/v2015-02/gmi.clim.CH2O.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s CH2O     - 1  1
#* GMI_LOSS_CH3Br     $ROOT/GMI/v2015-02/gmi.clim.CH3Br.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   CH3Br    - 1  1
#* GMI_PROD_CH3Br     $ROOT/GMI/v2015-02/gmi.clim.CH3Br.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s CH3Br    - 1  1
* GMI_LOSS_CH3CCl3    $ROOT/GMI/v2015-02/gmi.clim.CH3CCl3.geos5.2x25.nc     loss    2000/$MM/1/0 C xyz s-1   CH3CCl3  - 1  1
* GMI_PROD_CH3CCl3    $ROOT/GMI/v2015-02/gmi.clim.CH3CCl3.geos5.2x25.nc     prod    2000/$MM/1/0 C xyz v/v/s CH3CCl3  - 1  1
* GMI_LOSS_CH3Cl      $ROOT/GMI/v2015-02/gmi.clim.CH3Cl.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   CH3Cl    - 1  1
* GMI_PROD_CH3Cl      $ROOT/GMI/v2015-02/gmi.clim.CH3Cl.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s CH3Cl    - 1  1
* GMI_LOSS_CH4        $ROOT/GMI/v2015-02/gmi.clim.CH4.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   CH4      - 1  1
* GMI_PROD_CH4        $ROOT/GMI/v2015-02/gmi.clim.CH4.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s CH4      - 1  1
* GMI_LOSS_CO         $ROOT/GMI/v2015-02/gmi.clim.CO.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   CO       - 1  1
* GMI_PROD_CO         $ROOT/GMI/v2015-02/gmi.clim.CO.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s CO       - 1  1
* GMI_LOSS_Cl         $ROOT/GMI/v2015-02/gmi.clim.Cl.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   Cl       - 1  1
* GMI_PROD_Cl         $ROOT/GMI/v2015-02/gmi.clim.Cl.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s Cl       - 1  1
* GMI_LOSS_Cl2        $ROOT/GMI/v2015-02/gmi.clim.Cl2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   Cl2      - 1  1
* GMI_PROD_Cl2        $ROOT/GMI/v2015-02/gmi.clim.Cl2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s Cl2      - 1  1
* GMI_LOSS_Cl2O2      $ROOT/GMI/v2015-02/gmi.clim.Cl2O2.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   Cl2O2    - 1  1
* GMI_PROD_Cl2O2      $ROOT/GMI/v2015-02/gmi.clim.Cl2O2.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s Cl2O2    - 1  1
* GMI_LOSS_ClO        $ROOT/GMI/v2015-02/gmi.clim.ClO.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   ClO      - 1  1
* GMI_PROD_ClO        $ROOT/GMI/v2015-02/gmi.clim.ClO.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s ClO      - 1  1
* GMI_LOSS_ClONO2     $ROOT/GMI/v2015-02/gmi.clim.ClONO2.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   ClONO2   - 1  1
* GMI_PROD_ClONO2     $ROOT/GMI/v2015-02/gmi.clim.ClONO2.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s ClONO2   - 1  1
* GMI_LOSS_EOH        $ROOT/GMI/v2015-02/gmi.clim.EOH.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   EOH      - 1  1
* GMI_PROD_EOH        $ROOT/GMI/v2015-02/gmi.clim.EOH.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s EOH      - 1  1
* GMI_LOSS_ETO2       $ROOT/GMI/v2015-02/gmi.clim.ETO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ETO2     - 1  1
* GMI_PROD_ETO2       $ROOT/GMI/v2015-02/gmi.clim.ETO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ETO2     - 1  1
* GMI_LOSS_ETP        $ROOT/GMI/v2015-02/gmi.clim.ETP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   ETP      - 1  1
* GMI_PROD_ETP        $ROOT/GMI/v2015-02/gmi.clim.ETP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s ETP      - 1  1
* GMI_LOSS_GCO3       $ROOT/GMI/v2015-02/gmi.clim.GCO3.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   GCO3     - 1  1
* GMI_PROD_GCO3       $ROOT/GMI/v2015-02/gmi.clim.GCO3.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s GCO3     - 1  1
* GMI_LOSS_GLYC       $ROOT/GMI/v2015-02/gmi.clim.GLYC.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   GLYC     - 1  1
* GMI_PROD_GLYC       $ROOT/GMI/v2015-02/gmi.clim.GLYC.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s GLYC     - 1  1
* GMI_LOSS_GLYX       $ROOT/GMI/v2015-02/gmi.clim.GLYX.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   GLYX     - 1  1
* GMI_PROD_GLYX       $ROOT/GMI/v2015-02/gmi.clim.GLYX.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s GLYX     - 1  1
* GMI_LOSS_GP         $ROOT/GMI/v2015-02/gmi.clim.GP.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   GP       - 1  1
* GMI_PROD_GP         $ROOT/GMI/v2015-02/gmi.clim.GP.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s GP       - 1  1
* GMI_LOSS_GPAN       $ROOT/GMI/v2015-02/gmi.clim.GPAN.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   GPAN     - 1  1
* GMI_PROD_GPAN       $ROOT/GMI/v2015-02/gmi.clim.GPAN.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s GPAN     - 1  1
* GMI_LOSS_H          $ROOT/GMI/v2015-02/gmi.clim.H.geos5.2x25.nc           loss    2000/$MM/1/0 C xyz s-1   H        - 1  1
* GMI_PROD_H          $ROOT/GMI/v2015-02/gmi.clim.H.geos5.2x25.nc           prod    2000/$MM/1/0 C xyz v/v/s H        - 1  1
* GMI_LOSS_H2         $ROOT/GMI/v2015-02/gmi.clim.H2.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   H2       - 1  1
* GMI_PROD_H2         $ROOT/GMI/v2015-02/gmi.clim.H2.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s H2       - 1  1
* GMI_LOSS_H2402      $ROOT/GMI/v2015-02/gmi.clim.H2402.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   H2402    - 1  1
* GMI_PROD_H2402      $ROOT/GMI/v2015-02/gmi.clim.H2402.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s H2402    - 1  1
* GMI_LOSS_H2O        $ROOT/GMI/v2015-02/gmi.clim.H2O.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   H2O      - 1  1
* GMI_PROD_H2O        $ROOT/GMI/v2015-02/gmi.clim.H2O.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s H2O      - 1  1
* GMI_LOSS_H2O2       $ROOT/GMI/v2015-02/gmi.clim.H2O2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   H2O2     - 1  1
* GMI_PROD_H2O2       $ROOT/GMI/v2015-02/gmi.clim.H2O2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s H2O2     - 1  1
* GMI_LOSS_HAC        $ROOT/GMI/v2015-02/gmi.clim.HAC.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   HAC      - 1  1
* GMI_PROD_HAC        $ROOT/GMI/v2015-02/gmi.clim.HAC.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s HAC      - 1  1
#* GMI_LOSS_HBr       $ROOT/GMI/v2015-02/gmi.clim.HBr.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   HBr      - 1  1
#* GMI_PROD_HBr       $ROOT/GMI/v2015-02/gmi.clim.HBr.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s HBr      - 1  1
* GMI_LOSS_HCFC141b   $ROOT/GMI/v2015-02/gmi.clim.HCFC141b.geos5.2x25.nc    loss    2000/$MM/1/0 C xyz s-1   HCFC141b - 1  1
* GMI_PROD_HCFC141b   $ROOT/GMI/v2015-02/gmi.clim.HCFC141b.geos5.2x25.nc    prod    2000/$MM/1/0 C xyz v/v/s HCFC141b - 1  1
* GMI_LOSS_HCFC142b   $ROOT/GMI/v2015-02/gmi.clim.HCFC142b.geos5.2x25.nc    loss    2000/$MM/1/0 C xyz s-1   HCFC142b - 1  1
* GMI_PROD_HCFC142b   $ROOT/GMI/v2015-02/gmi.clim.HCFC142b.geos5.2x25.nc    prod    2000/$MM/1/0 C xyz v/v/s HCFC142b - 1  1
* GMI_LOSS_HCFC22     $ROOT/GMI/v2015-02/gmi.clim.HCFC22.geos5.2x25.nc      loss    2000/$MM/1/0 C xyz s-1   HCFC22   - 1  1
* GMI_PROD_HCFC22     $ROOT/GMI/v2015-02/gmi.clim.HCFC22.geos5.2x25.nc      prod    2000/$MM/1/0 C xyz v/v/s HCFC22   - 1  1
* GMI_LOSS_HCOOH      $ROOT/GMI/v2015-02/gmi.clim.HCOOH.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   HCOOH    - 1  1
* GMI_PROD_HCOOH      $ROOT/GMI/v2015-02/gmi.clim.HCOOH.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s HCOOH    - 1  1
* GMI_LOSS_HCl        $ROOT/GMI/v2015-02/gmi.clim.HCl.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   HCl      - 1  1
* GMI_PROD_HCl        $ROOT/GMI/v2015-02/gmi.clim.HCl.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s HCl      - 1  1
* GMI_LOSS_HNO2       $ROOT/GMI/v2015-02/gmi.clim.HNO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   HNO2     - 1  1
* GMI_PROD_HNO2       $ROOT/GMI/v2015-02/gmi.clim.HNO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s HNO2     - 1  1
* GMI_LOSS_HNO3       $ROOT/GMI/v2015-02/gmi.clim.HNO3.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   HNO3     - 1  1
* GMI_PROD_HNO3       $ROOT/GMI/v2015-02/gmi.clim.HNO3.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s HNO3     - 1  1
* GMI_LOSS_HNO4       $ROOT/GMI/v2015-02/gmi.clim.HNO4.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   HNO4     - 1  1
* GMI_PROD_HNO4       $ROOT/GMI/v2015-02/gmi.clim.HNO4.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s HNO4     - 1  1
* GMI_LOSS_HO2        $ROOT/GMI/v2015-02/gmi.clim.HO2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   HO2      - 1  1
* GMI_PROD_HO2        $ROOT/GMI/v2015-02/gmi.clim.HO2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s HO2      - 1  1
#* GMI_LOSS_HOBr      $ROOT/GMI/v2015-02/gmi.clim.HOBr.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   HOBr     - 1  1
#* GMI_PROD_HOBr      $ROOT/GMI/v2015-02/gmi.clim.HOBr.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s HOBr     - 1  1
* GMI_LOSS_HOCl       $ROOT/GMI/v2015-02/gmi.clim.HOCl.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   HOCl     - 1  1
* GMI_PROD_HOCl       $ROOT/GMI/v2015-02/gmi.clim.HOCl.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s HOCl     - 1  1
* GMI_LOSS_IALD       $ROOT/GMI/v2015-02/gmi.clim.IALD.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   IALD     - 1  1
* GMI_PROD_IALD       $ROOT/GMI/v2015-02/gmi.clim.IALD.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s IALD     - 1  1
* GMI_LOSS_IAO2       $ROOT/GMI/v2015-02/gmi.clim.IAO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   IAO2     - 1  1
* GMI_PROD_IAO2       $ROOT/GMI/v2015-02/gmi.clim.IAO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s IAO2     - 1  1
* GMI_LOSS_IAP        $ROOT/GMI/v2015-02/gmi.clim.IAP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   IAP      - 1  1
* GMI_PROD_IAP        $ROOT/GMI/v2015-02/gmi.clim.IAP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s IAP      - 1  1
* GMI_LOSS_INO2       $ROOT/GMI/v2015-02/gmi.clim.INO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   INO2     - 1  1
* GMI_PROD_INO2       $ROOT/GMI/v2015-02/gmi.clim.INO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s INO2     - 1  1
* GMI_LOSS_INPN       $ROOT/GMI/v2015-02/gmi.clim.INPN.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   INPN     - 1  1
* GMI_PROD_INPN       $ROOT/GMI/v2015-02/gmi.clim.INPN.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s INPN     - 1  1
* GMI_LOSS_ISN1       $ROOT/GMI/v2015-02/gmi.clim.ISN1.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ISN1     - 1  1
* GMI_PROD_ISN1       $ROOT/GMI/v2015-02/gmi.clim.ISN1.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ISN1     - 1  1
* GMI_LOSS_ISNP       $ROOT/GMI/v2015-02/gmi.clim.ISNP.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ISNP     - 1  1
* GMI_PROD_ISNP       $ROOT/GMI/v2015-02/gmi.clim.ISNP.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ISNP     - 1  1
* GMI_LOSS_ISOP       $ROOT/GMI/v2015-02/gmi.clim.ISOP.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   ISOP     - 1  1
* GMI_PROD_ISOP       $ROOT/GMI/v2015-02/gmi.clim.ISOP.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s ISOP     - 1  1
* GMI_LOSS_KO2        $ROOT/GMI/v2015-02/gmi.clim.KO2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   KO2      - 1  1
* GMI_PROD_KO2        $ROOT/GMI/v2015-02/gmi.clim.KO2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s KO2      - 1  1
* GMI_LOSS_MACR       $ROOT/GMI/v2015-02/gmi.clim.MACR.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MACR     - 1  1
* GMI_PROD_MACR       $ROOT/GMI/v2015-02/gmi.clim.MACR.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MACR     - 1  1
* GMI_LOSS_MAN2       $ROOT/GMI/v2015-02/gmi.clim.MAN2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MAN2     - 1  1
* GMI_PROD_MAN2       $ROOT/GMI/v2015-02/gmi.clim.MAN2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MAN2     - 1  1
* GMI_LOSS_MAO3       $ROOT/GMI/v2015-02/gmi.clim.MAO3.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MAO3     - 1  1
* GMI_PROD_MAO3       $ROOT/GMI/v2015-02/gmi.clim.MAO3.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MAO3     - 1  1
* GMI_LOSS_MAOP       $ROOT/GMI/v2015-02/gmi.clim.MAOP.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MAOP     - 1  1
* GMI_PROD_MAOP       $ROOT/GMI/v2015-02/gmi.clim.MAOP.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MAOP     - 1  1
* GMI_LOSS_MAP        $ROOT/GMI/v2015-02/gmi.clim.MAP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MAP      - 1  1
* GMI_PROD_MAP        $ROOT/GMI/v2015-02/gmi.clim.MAP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MAP      - 1  1
* GMI_LOSS_MCO3       $ROOT/GMI/v2015-02/gmi.clim.MCO3.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MCO3     - 1  1
* GMI_PROD_MCO3       $ROOT/GMI/v2015-02/gmi.clim.MCO3.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MCO3     - 1  1
* GMI_LOSS_MEK        $ROOT/GMI/v2015-02/gmi.clim.MEK.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MEK      - 1  1
* GMI_PROD_MEK        $ROOT/GMI/v2015-02/gmi.clim.MEK.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MEK      - 1  1
* GMI_LOSS_MGLY       $ROOT/GMI/v2015-02/gmi.clim.MGLY.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MGLY     - 1  1
* GMI_PROD_MGLY       $ROOT/GMI/v2015-02/gmi.clim.MGLY.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MGLY     - 1  1
* GMI_LOSS_MO2        $ROOT/GMI/v2015-02/gmi.clim.MO2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MO2      - 1  1
* GMI_PROD_MO2        $ROOT/GMI/v2015-02/gmi.clim.MO2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MO2      - 1  1
* GMI_LOSS_MOH        $ROOT/GMI/v2015-02/gmi.clim.MOH.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MOH      - 1  1
* GMI_PROD_MOH        $ROOT/GMI/v2015-02/gmi.clim.MOH.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MOH      - 1  1
* GMI_LOSS_MP         $ROOT/GMI/v2015-02/gmi.clim.MP.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   MP       - 1  1
* GMI_PROD_MP         $ROOT/GMI/v2015-02/gmi.clim.MP.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s MP       - 1  1
* GMI_LOSS_MRO2       $ROOT/GMI/v2015-02/gmi.clim.MRO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MRO2     - 1  1
* GMI_PROD_MRO2       $ROOT/GMI/v2015-02/gmi.clim.MRO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MRO2     - 1  1
* GMI_LOSS_MRP        $ROOT/GMI/v2015-02/gmi.clim.MRP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MRP      - 1  1
* GMI_PROD_MRP        $ROOT/GMI/v2015-02/gmi.clim.MRP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MRP      - 1  1
* GMI_LOSS_MVK        $ROOT/GMI/v2015-02/gmi.clim.MVK.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   MVK      - 1  1
* GMI_PROD_MVK        $ROOT/GMI/v2015-02/gmi.clim.MVK.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s MVK      - 1  1
* GMI_LOSS_MVN2       $ROOT/GMI/v2015-02/gmi.clim.MVN2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   MVN2     - 1  1
* GMI_PROD_MVN2       $ROOT/GMI/v2015-02/gmi.clim.MVN2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s MVN2     - 1  1
* GMI_LOSS_N          $ROOT/GMI/v2015-02/gmi.clim.N.geos5.2x25.nc           loss    2000/$MM/1/0 C xyz s-1   N        - 1  1
* GMI_PROD_N          $ROOT/GMI/v2015-02/gmi.clim.N.geos5.2x25.nc           prod    2000/$MM/1/0 C xyz v/v/s N        - 1  1
* GMI_LOSS_N2O        $ROOT/GMI/v2015-02/gmi.clim.N2O.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   N2O      - 1  1
* GMI_PROD_N2O        $ROOT/GMI/v2015-02/gmi.clim.N2O.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s N2O      - 1  1
* GMI_LOSS_N2O5       $ROOT/GMI/v2015-02/gmi.clim.N2O5.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   N2O5     - 1  1
* GMI_PROD_N2O5       $ROOT/GMI/v2015-02/gmi.clim.N2O5.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s N2O5     - 1  1
* GMI_LOSS_NO         $ROOT/GMI/v2015-02/gmi.clim.NO.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   NO       - 1  1
* GMI_PROD_NO         $ROOT/GMI/v2015-02/gmi.clim.NO.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s NO       - 1  1
* GMI_LOSS_NO2        $ROOT/GMI/v2015-02/gmi.clim.NO2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   NO2      - 1  1
* GMI_PROD_NO2        $ROOT/GMI/v2015-02/gmi.clim.NO2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s NO2      - 1  1
* GMI_LOSS_NO3        $ROOT/GMI/v2015-02/gmi.clim.NO3.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   NO3      - 1  1
* GMI_PROD_NO3        $ROOT/GMI/v2015-02/gmi.clim.NO3.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s NO3      - 1  1
* GMI_LOSS_NOx        $ROOT/GMI/v2015-02/gmi.clim.NOx.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   NOx      - 1  1
* GMI_PROD_NOx        $ROOT/GMI/v2015-02/gmi.clim.NOx.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s NOx      - 1  1
* GMI_LOSS_O          $ROOT/GMI/v2015-02/gmi.clim.O.geos5.2x25.nc           loss    2000/$MM/1/0 C xyz s-1   O        - 1  1
* GMI_PROD_O          $ROOT/GMI/v2015-02/gmi.clim.O.geos5.2x25.nc           prod    2000/$MM/1/0 C xyz v/v/s O        - 1  1
* GMI_LOSS_O1D        $ROOT/GMI/v2015-02/gmi.clim.O1D.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   O1D      - 1  1
* GMI_PROD_O1D        $ROOT/GMI/v2015-02/gmi.clim.O1D.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s O1D      - 1  1
* GMI_LOSS_O3         $ROOT/GMI/v2015-02/gmi.clim.O3.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   O3       - 1  1
* GMI_PROD_O3         $ROOT/GMI/v2015-02/gmi.clim.O3.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s O3       - 1  1
* GMI_LOSS_OClO       $ROOT/GMI/v2015-02/gmi.clim.OClO.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   OClO     - 1  1
* GMI_PROD_OClO       $ROOT/GMI/v2015-02/gmi.clim.OClO.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s OClO     - 1  1
* GMI_LOSS_OH         $ROOT/GMI/v2015-02/gmi.clim.OH.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   OH       - 1  1
* GMI_PROD_OH         $ROOT/GMI/v2015-02/gmi.clim.OH.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s OH       - 1  1
* GMI_LOSS_Ox         $ROOT/GMI/v2015-02/gmi.clim.Ox.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   Ox       - 1  1
* GMI_PROD_Ox         $ROOT/GMI/v2015-02/gmi.clim.Ox.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s Ox       - 1  1
* GMI_LOSS_PAN        $ROOT/GMI/v2015-02/gmi.clim.PAN.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   PAN      - 1  1
* GMI_PROD_PAN        $ROOT/GMI/v2015-02/gmi.clim.PAN.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s PAN      - 1  1
* GMI_LOSS_PMN        $ROOT/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   PMN      - 1  1
* GMI_PROD_PMN        $ROOT/GMI/v2015-02/gmi.clim.PMN.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s PMN      - 1  1
* GMI_LOSS_PO2        $ROOT/GMI/v2015-02/gmi.clim.PO2.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   PO2      - 1  1
* GMI_PROD_PO2        $ROOT/GMI/v2015-02/gmi.clim.PO2.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s PO2      - 1  1
* GMI_LOSS_PP         $ROOT/GMI/v2015-02/gmi.clim.PP.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   PP       - 1  1
* GMI_PROD_PP         $ROOT/GMI/v2015-02/gmi.clim.PP.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s PP       - 1  1
* GMI_LOSS_PPN        $ROOT/GMI/v2015-02/gmi.clim.PPN.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   PPN      - 1  1
* GMI_PROD_PPN        $ROOT/GMI/v2015-02/gmi.clim.PPN.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s PPN      - 1  1
* GMI_LOSS_PRN1       $ROOT/GMI/v2015-02/gmi.clim.PRN1.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   PRN1     - 1  1
* GMI_PROD_PRN1       $ROOT/GMI/v2015-02/gmi.clim.PRN1.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s PRN1     - 1  1
* GMI_LOSS_PRPE       $ROOT/GMI/v2015-02/gmi.clim.PRPE.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   PRPE     - 1  1
* GMI_PROD_PRPE       $ROOT/GMI/v2015-02/gmi.clim.PRPE.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s PRPE     - 1  1
* GMI_LOSS_PRPN       $ROOT/GMI/v2015-02/gmi.clim.PRPN.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   PRPN     - 1  1
* GMI_PROD_PRPN       $ROOT/GMI/v2015-02/gmi.clim.PRPN.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s PRPN     - 1  1
* GMI_LOSS_R4N1       $ROOT/GMI/v2015-02/gmi.clim.R4N1.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   R4N1     - 1  1
* GMI_PROD_R4N1       $ROOT/GMI/v2015-02/gmi.clim.R4N1.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s R4N1     - 1  1
* GMI_LOSS_R4N2       $ROOT/GMI/v2015-02/gmi.clim.R4N2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   R4N2     - 1  1
* GMI_PROD_R4N2       $ROOT/GMI/v2015-02/gmi.clim.R4N2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s R4N2     - 1  1
* GMI_LOSS_R4O2       $ROOT/GMI/v2015-02/gmi.clim.R4O2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   R4O2     - 1  1
* GMI_PROD_R4O2       $ROOT/GMI/v2015-02/gmi.clim.R4O2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s R4O2     - 1  1
* GMI_LOSS_R4P        $ROOT/GMI/v2015-02/gmi.clim.R4P.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   R4P      - 1  1
* GMI_PROD_R4P        $ROOT/GMI/v2015-02/gmi.clim.R4P.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s R4P      - 1  1
* GMI_LOSS_RA3P       $ROOT/GMI/v2015-02/gmi.clim.RA3P.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   RA3P     - 1  1
* GMI_PROD_RA3P       $ROOT/GMI/v2015-02/gmi.clim.RA3P.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s RA3P     - 1  1
* GMI_LOSS_RB3P       $ROOT/GMI/v2015-02/gmi.clim.RB3P.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   RB3P     - 1  1
* GMI_PROD_RB3P       $ROOT/GMI/v2015-02/gmi.clim.RB3P.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s RB3P     - 1  1
* GMI_LOSS_RCHO       $ROOT/GMI/v2015-02/gmi.clim.RCHO.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   RCHO     - 1  1
* GMI_PROD_RCHO       $ROOT/GMI/v2015-02/gmi.clim.RCHO.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s RCHO     - 1  1
* GMI_LOSS_RCO3       $ROOT/GMI/v2015-02/gmi.clim.RCO3.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   RCO3     - 1  1
* GMI_PROD_RCO3       $ROOT/GMI/v2015-02/gmi.clim.RCO3.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s RCO3     - 1  1
* GMI_LOSS_RCOOH      $ROOT/GMI/v2015-02/gmi.clim.RCOOH.geos5.2x25.nc       loss    2000/$MM/1/0 C xyz s-1   RCOOH    - 1  1
* GMI_PROD_RCOOH      $ROOT/GMI/v2015-02/gmi.clim.RCOOH.geos5.2x25.nc       prod    2000/$MM/1/0 C xyz v/v/s RCOOH    - 1  1
* GMI_LOSS_RIO1       $ROOT/GMI/v2015-02/gmi.clim.RIO1.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   RIO1     - 1  1
* GMI_PROD_RIO1       $ROOT/GMI/v2015-02/gmi.clim.RIO1.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s RIO1     - 1  1
* GMI_LOSS_RIP        $ROOT/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   RIP      - 1  1
* GMI_PROD_RIP        $ROOT/GMI/v2015-02/gmi.clim.RIP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s RIP      - 1  1
* GMI_LOSS_ROH        $ROOT/GMI/v2015-02/gmi.clim.ROH.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   ROH      - 1  1
* GMI_PROD_ROH        $ROOT/GMI/v2015-02/gmi.clim.ROH.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s ROH      - 1  1
* GMI_LOSS_RP         $ROOT/GMI/v2015-02/gmi.clim.RP.geos5.2x25.nc          loss    2000/$MM/1/0 C xyz s-1   RP       - 1  1
* GMI_PROD_RP         $ROOT/GMI/v2015-02/gmi.clim.RP.geos5.2x25.nc          prod    2000/$MM/1/0 C xyz v/v/s RP       - 1  1
* GMI_LOSS_VRO2       $ROOT/GMI/v2015-02/gmi.clim.VRO2.geos5.2x25.nc        loss    2000/$MM/1/0 C xyz s-1   VRO2     - 1  1
* GMI_PROD_VRO2       $ROOT/GMI/v2015-02/gmi.clim.VRO2.geos5.2x25.nc        prod    2000/$MM/1/0 C xyz v/v/s VRO2     - 1  1
* GMI_LOSS_VRP        $ROOT/GMI/v2015-02/gmi.clim.VRP.geos5.2x25.nc         loss    2000/$MM/1/0 C xyz s-1   VRP      - 1  1
* GMI_PROD_VRP        $ROOT/GMI/v2015-02/gmi.clim.VRP.geos5.2x25.nc         prod    2000/$MM/1/0 C xyz v/v/s VRP      - 1  1

# Archived OH concentrations. These are always needed, so set species to wildcard (*) to make
# sure that this entry will always be read. 
* STRAT_OH            $ROOT/GMI/v2015-02/gmi.clim.OH.geos5.2x25.nc          species 2000/$MM/1/0 C xyz v/v   *        - 1  1
)))+LinStratChem+

### END SECTION BASE EMISSIONS ###

###############################################################################
### BEGIN SECTION SCALE FACTORS 
###############################################################################

# ScalID Name sourceFile sourceVar sourceTime C/R/E SrcDim SrcUnit Oper

#==============================================================================
# --- annual scale factors ---
#==============================================================================
1  TOTFUEL_THISYR    $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 1985-2010/1/1/0 C xy 1  1
2  TOTFUEL_1985      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 1985/1/1/0      C xy 1 -1
3  TOTFUEL_1999      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 1999/1/1/0      C xy 1 -1
4  TOTFUEL_2006      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 2006/1/1/0      C xy 1 -1
5  TOTFUEL_2002      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 2002/1/1/0      C xy 1 -1
16 TOTFUEL_2005      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 2005/1/1/0      C xy 1 -1
27 TOTFUEL_2008_2010 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 2008-2010/1/1/0 C xy 1 -1
40 TOTFUEL_1985_2008 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 1985-2008/1/1/0 C xy 1 -1
6  LIQFUEL_THISYR    $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  1985-2010/1/1/0 C xy 1  1
7  LIQFUEL_1985      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  1985/1/1/0      C xy 1 -1
8  LIQFUEL_1999      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  1999/1/1/0      C xy 1 -1
9  LIQFUEL_2006      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  2006/1/1/0      C xy 1 -1
10 LIQFUEL_2002      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  2002/1/1/0      C xy 1 -1
17 LIQFUEL_2005      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  2005/1/1/0      C xy 1 -1
28 LIQFUEL_2008_2010 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  2008-2010/1/1/0 C xy 1 -1
41 LIQFUEL_1985_2008 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  1985-2008/1/1/0 C xy 1 -1
11 SOLFUEL_THISYR    $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 1985-2010/1/1/0 C xy 1  1
12 SOLFUEL_1985      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 1985/1/1/0      C xy 1 -1
13 SOLFUEL_1999      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 1999/1/1/0      C xy 1 -1
14 SOLFUEL_2006      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 2006/1/1/0      C xy 1 -1
15 SOLFUEL_2002      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 2002/1/1/0      C xy 1 -1
18 SOLFUEL_2005      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 2005/1/1/0      C xy 1 -1
19 SOLFUEL_2008      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 2008/1/1/0      C xy 1 -1
29 SOLFUEL_2008_2010 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 2008-2010/1/1/0 C xy 1 -1
42 SOLFUEL_1985_2008 $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc SO2scalar 1985-2008/1/1/0 C xy 1 -1
23 LIQFUEL_2008      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc COscalar  2008/1/1/0      C xy 1 -1
24 TOTFUEL_2008      $ROOT/AnnualScalar/v2014-07/AnnualScalar.geos.1x1.nc NOxscalar 2008/1/1/0      C xy 1 -1

#==============================================================================
# --- temporary scale factors for comparisons
#==============================================================================
919 NO_ratio $ROOT/AnnualScalar/v2014-07/NO_ratio_2005_2002.nc NOXscalar 2005/1/1/0 C xy unitless 1
918 CO_ratio $ROOT/AnnualScalar/v2014-07/CO_ratio_2005_1985.nc COscalar 2005/1/1/0 C xy unitless 1

#==============================================================================
# --- day-of-week scale factors ---
# ==> data is Sun/Mon/.../Sat 
#==============================================================================
20 GEIA_DOW_NOX 0.784/1.0706/1.0706/1.0706/1.0706/1.0706/0.863 - - - xy unitless 1
21 GEIA_DOW_CO  0.683/1.1076/1.0706/1.0706/1.0706/1.0706/0.779 - - - xy unitless 1
22 GEIA_DOW_HC  0.671/1.1102/1.1102/1.1102/1.1102/1.1102/0.768 - - - xy unitless 1 

#==============================================================================
# --- diurnal scale factors --- 
#==============================================================================
25 EDGAR_TODNOX $ROOT/EDGARv42/v2015-02/NO/EDGAR_hourly_NOxScal.nc NOXscale 2000/1/1/HH C xy unitless 1
26 GEIA_TOD_FOSSIL 0.45/0.45/0.6/0.6/0.6/0.6/1.45/1.45/1.45/1.45/1.4/1.4/1.4/1.4/1.45/1.45/1.45/1.45/0.65/0.65/0.65/0.65/0.45/0.45 - - - xy unitless 1

#==============================================================================
# --- seasonal scale factors ---
#==============================================================================
# from GEIA:
30 GEIA_SEASON_NOX  $ROOT/GEIA/v2014-07/GEIA_monthscal.generic.1x1.nc NOXrat 1985/1-12/1/0 C xy unitless 1
31 GEIA_SEASON_SO2  $ROOT/GEIA/v2014-07/GEIA_monthscal.generic.1x1.nc SO2rat 1985/1-12/1/0 C xy unitless 1

# from EMEP:
32 EMEP_SEASON_NOX $ROOT/EMEP/v2015-03/EMEP.Seasonal.geos.1x1.nc NOXrat 2005/1-12/1/0 C xy unitless 1
33 EMEP_SEASON_CO  $ROOT/EMEP/v2015-03/EMEP.Seasonal.geos.1x1.nc COrat  2005/1-12/1/0 C xy unitless 1
34 EMEP_SEASON_NH3 $ROOT/EMEP/v2015-03/EMEP.Seasonal.geos.1x1.nc NH3rat 2005/1-12/1/0 C xy unitless 1
35 EMEP_SEASON_SO2 $ROOT/EMEP/v2015-03/EMEP.Seasonal.geos.1x1.nc SO2rat 2005/1-12/1/0 C xy unitless 1

# from Streets:
36 ZHANG_SEASON_NOX   $ROOT/STREETS/v2014-07/2006/Streets_2004_NOx_MonthFctr_total.generic.1x1.nc NOxrat    2004/1-12/1/0 C xy unitless 1
37 ZHANG_SEASON_CO    $ROOT/STREETS/v2014-07/2006/Streets_2001_CO_MonthFctr_total.generic.1x1.nc  ratio     2001/1-12/1/0 C xy unitless 1 
38 STREETS_SEASON_NH3 $ROOT/STREETS/v2014-07/2000/Streets_NH3_scale.generic.1x1.nc                NH3_scale 1995/1-12/1/0 C xy unitless 1 

# for Bromocarbons:
39 BROMOCARB_SEASON $ROOT/BROMINE/v2015-02/BromoCarb_Season.nc CHXBRY_scale 2000/1-12/1/0 C xy unitless 1

#==============================================================================
# --- VOC speciations ---
#==============================================================================

50 RETRO_KET2MEK    0.25  - - - xy unitless 1
51 RETRO_KET2ACET   0.75  - - - xy unitless 1
52 COPROD_FOSSIL    1.02  - - - xy unitless 1
53 COPROD_BIOFUEL   1.086 - - - xy unitless 1
54 COPROD_BIOMASS   1.05  - - - xy unitless 1
55 ACETSCAL_FOSSIL  0.82  - - - xy unitless 1
56 ACETSCAL_BIOFUEL 0.82  - - - xy unitless 1

#==============================================================================
# --- SOx to SO2 conversion (Chin et al., 2000) ---
#==============================================================================
60 SOX2SO2_GLOBAL 0.986 - - - xy unitless 1
61 SOX2SO2_EU     0.95  - - - xy unitless 1
62 SULFUR2SOX     2.0   - - - xy unitless 1
63 SO2toSO4       0.031 - - - xy unitless 1
64 SOX2SO4_EU     0.05  - - - xy unitless 1
65 SO2toSO4_CAC   0.014 - - - xy unitless 1

#==============================================================================
# --- Carbon aerosols: speciation of hydrophilic and hydrophobic fractions ---
#
# Fractions applied to the biomass burning extensions (GFED3 or FINN) are
# specified separately in the extensions section.
#==============================================================================
70 BC2BCPI  0.2  - - - xy unitless 1
71 BC2BCPO  0.8  - - - xy unitless 1
72 OC2OCPI  0.5  - - - xy unitless 1
73 OC2OCPO  0.5  - - - xy unitless 1
74 POASCAL  1.27 - - - xy unitless 1

#==============================================================================
# --- NAP scale factors ---
#
# Get anthropogenic (FF) NAP emissions by scaling BENZ emissions with the
# following factor. Factor is ratio of TgC NAP to TgC BENZ emissions
# or equivalently, molec C NAP to molec C BENZ. Scaling should produce
# about 0.09 TgC NAP/year, consistent with non-BB,BF emissions predicted
# by Zhang and Tao 2009 Atm Env
# Based on year 2000 1x1 inv  (hotp 11/14/09)
#REAL*8, PARAMETER    :: NAPTOBENZSCALE = 0.06861d0

# NAPTOTSCAL: factor to scale total NAP emissions to POA (hotp 7/24/09)
#REAL*8, PARAMETER    :: NAPTOTALSCALE = 66.09027d0
 
# = CO emissions * emissions ratio of mol NAP / mol CO 
# * kg C / mol NAP * mol CO / kg CO 
# mmol NAP / mol CO = 0.025 g NAP/ kg DM / 
#              ( 78 g CO/ kg DM ) * 28 g CO / mol CO
#            / ( 128 g NAP / mol NAP ) *1000 mmol/mol
# scale emissions down if appropriate to remove the
# effect of VOC ox on CO emission
# EF for NAP from Andreae and Merlet 2001 Glob Biog Cyc
# EF for CO  from Andreae and Merlet 2001 Glob Biog Cyc
#BIOFUEL_KG(N,:,:) = BIOFUEL_KG(IDBFCO,:,:) * 0.0701d-3 
#                  * 120d0 / 28d0 * COSCALEDOWN
#==============================================================================
80 NAPEMISS   1.0     - - - xy unitless 1
81 NAPTOTSCAL 66.09   - - - xy unitless 1
82 BENZTONAP  6.86e-2 - - - xy unitless 1 
83 BF_COtoNAP 3.00e-4 - - - xy unitless 1

#==============================================================================
# --- Biofuel conversion factors ---
#==============================================================================
90 BF_COtoHAC   8.75e-3 - - - xy unitless 1
91 BF_COtoSO2   3.43e-3 - - - xy unitless 1
92 BF_COtoGLYX  1.37e-2 - - - xy unitless 1
93 BF_COtoMGLY  8.92e-3 - - - xy unitless 1
94 BF_COtoBENZ  1.04e-2 - - - xy unitless 1
95 BF_COtoTOLU  6.03e-3 - - - xy unitless 1
96 BF_COtoXYLE  2.81e-2 - - - xy unitless 1
97 BF_COtoC2H4  1.35e-2 - - - xy unitless 1
98 BF_COtoC2H2  1.63e-2 - - - xy unitless 1
99 BF_COtoGLYC  7.84e-3 - - - xy unitless 1

#==============================================================================
# --- AEIC aircraft emissions ---
#
# Sulfur conversion factors are calculated as 
#     so4 = 3 * a * b and so2 = 2 * a * (1-b)
#
# where 
#     a = fraction by mass (6.0e-4) and 
#     b = conversion efficiency (2.0e-2).
#
# The factors 2 and 3 come from sulfur mass conversions (96/32 and 64/32).
# All factors are taken from AEIC_mod.F, following Seb Estham's appraoch.
# Note that all emissions become multiplied by a factor of 1e-3 (except for 
# the fuelburn emissions) in the original AEIC code. I'm not sure if this 
# is because the netCDF data is in g instead of kg?
#==============================================================================
101 AEICACET 3.693477e-3 - -  - xy unitless 1
102 AEICALD2 4.271822e-2 - -  - xy unitless 1
103 AEICALK4 2.137911e-1 - -  - xy unitless 1
104 AEICC2H6 5.214505e-3 - -  - xy unitless 1
105 AEICC3H8 7.808710e-4 - -  - xy unitless 1
106 AEICCH2O 1.230811e-1 - -  - xy unitless 1
107 AEICPRPE 1.780418e-1 - -  - xy unitless 1
108 AEICMACR 5.362609e-2 - -  - xy unitless 1
109 AEICRCHO 3.676944e-2 - -  - xy unitless 1
110 AEICNOCO 1.000000e-3 - -  - xy unitless 1
111 AEICSO2  1.176000e-3 - -  - xy unitless 1
112 AEICSO4  3.600000e-5 - -  - xy unitless 1
113 AEICBC   3.000000e-5 - -  - xy unitless 1
114 AEICHC   1.160000e-3 - -  - xy unitless 1
115 NO2toNO  6.521739e-1 - -  - xy unitless 1

#==============================================================================
# --- NEI 2005 scale factors ---
#==============================================================================
201 VISTAS_SEASON     $ROOT/NEI2005/v2014-09/scaling/Vistas_season.geos.1x1.nc       NOratio      2002/1-12/1/0 C  xy unitless 1
202 ARP_SEASON        $ROOT/NEI2005/v2014-09/scaling/ARP_season.geos.1x1.nc          NOxrat  1999-2007/1-12/1/0 C  xy unitless 1
210 NEI99_DOW_NOX     $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           NOX          1999/1-12/WD/0 C xy unitless 1
211 NEI99_DOW_CO      $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           CO           1999/1-12/WD/0 C xy unitless 1
212 NEI99_DOW_ALK4    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           ALK4         1999/1-12/WD/0 C xy unitless 1
213 NEI99_DOW_ACET    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           ACET         1999/1-12/WD/0 C xy unitless 1
214 NEI99_DOW_MEK     $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           MEK          1999/1-12/WD/0 C xy unitless 1
215 NEI99_DOW_PRPE    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           PRPE         1999/1-12/WD/0 C xy unitless 1
216 NEI99_DOW_C3H8    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           C3H8         1999/1-12/WD/0 C xy unitless 1
217 NEI99_DOW_C2H6    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           C2H6         1999/1-12/WD/0 C xy unitless 1
218 NEI99_DOW_SO2     $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           SO2          1999/1-12/WD/0 C xy unitless 1
219 NEI99_DOW_SO4     $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           SO4          1999/1-12/WD/0 C xy unitless 1
220 NEI99_DOW_MSA     $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           MSA          1999/1-12/WD/0 C xy unitless 1
221 NEI99_DOW_BCPI    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           BCPI         1999/1-12/WD/0 C xy unitless 1
222 NEI99_DOW_OCPI    $ROOT/NEI2005/v2014-09/scaling/NEI99.dow.geos.1x1.nc           OCPI         1999/1-12/WD/0 C xy unitless 1
230 NEI99_SEASON_CO   $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        CO           1999/1-12/1/0 C  xy unitless 1
231 NEI99_SEASON_ALK4 $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        ALK4         1999/1-12/1/0 C  xy unitless 1
232 NEI99_SEASON_ACET $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        ACET         1999/1-12/1/0 C  xy unitless 1
233 NEI99_SEASON_MEK  $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        MEK          1999/1-12/1/0 C  xy unitless 1
234 NEI99_SEASON_PRPE $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        PRPE         1999/1-12/1/0 C  xy unitless 1
235 NEI99_SEASON_C3H8 $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        C3H8         1999/1-12/1/0 C  xy unitless 1
236 NEI99_SEASON_C2H6 $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        C2H6         1999/1-12/1/0 C  xy unitless 1
237 NEI99_SEASON_SO2  $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        SO2          1999/1-12/1/0 C  xy unitless 1
238 NEI99_SEASON_SO4  $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        SO4          1999/1-12/1/0 C  xy unitless 1
239 NEI99_SEASON_MSA  $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        MSA          1999/1-12/1/0 C  xy unitless 1
240 NEI99_SEASON_BCPI $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        BCPI         1999/1-12/1/0 C  xy unitless 1
241 NEI99_SEASON_OCPI $ROOT/NEI2005/v2014-09/scaling/NEI99.season.geos.1x1.nc        OCPI         1999/1-12/1/0 C  xy unitless 1
242 NEI99_SEASON_NH3  0.216/0.418/0.622/0.815/0.982/0.974/1.0/0.9/0.96/0.6/0.28/0.236 -            -             - xy unitless 1

#==============================================================================
# --- NEI 20011 scale factors ---
#==============================================================================
251 NEI11_NO_YRSCALE  1.337/1.255/1.172/1.097/1.034/1.0/0.939/0.887 - 2006-2013/1/1/0 C xy 1 1 
252 NEI11_CO_YRSCALE  1.271/1.227/1.104/0.998/1.019/1.0/0.981/0.962 - 2006-2013/1/1/0 C xy 1 1 
253 NEI11_NH3_YRSCALE 0.966/1.002/1.019/1.015/1.010/1.0/0.999/0.998 - 2006-2013/1/1/0 C xy 1 1 
254 NEI11_VOC_YRSCALE 1.083/1.093/1.011/1.000/1.016/1.0/0.986/0.971 - 2006-2013/1/1/0 C xy 1 1 
255 NEI11_SO2_YRSCALE 2.038/1.813/1.600/1.408/1.200/1.0/0.800/0.738 - 2006-2013/1/1/0 C xy 1 1 
256 NEI11_BC_YRSCALE  1.006/1.034/0.996/0.995/0.993/1.0/0.995/0.991 - 2006-2013/1/1/0 C xy 1 1 
257 NEI11_OC_YRSCALE  1.006/1.034/0.996/0.995/0.993/1.0/0.995/0.991 - 2006-2013/1/1/0 C xy 1 1 
260 NEI11_PAR2ACET    0.06                                          - -               - xy 1 1
261 NEI11_PAR2C3H8    0.03                                          - -               - xy 1 1
262 NEI11_PAR2MEK     0.02                                          - -               - xy 1 1
263 NEI11_PAR2ALK4    0.87                                          - -               - xy 1 1
264 NEI11_OLE2PRPE    0.5                                           - -               - xy 1 1
265 NEI11_BC2BCPI     0.2                                           - -               - xy 1 1
266 NEI11_BC2BCPO     0.8                                           - -               - xy 1 1
267 NEI11_OC2OCPI     0.5                                           - -               - xy 1 1
268 NEI11_OC2OCPO     0.5                                           - -               - xy 1 1

### END SECTION SCALE FACTORS ###

###############################################################################
### BEGIN SECTION MASKS 
###############################################################################

# ScalID Name sourceFile sourceVar sourceTime C/R/E SrcDim SrcUnit Oper Lon1/Lat1/Lon2/Lat2

#==============================================================================
# Country/region masks
#==============================================================================
1000 EMEP_MASK   $ROOT/MASKS/v2014-07/EMEP_mask.geos.1x1.nc            MASK     2000/1/1/0 C xy unitless 1 -30/30/45/70
1001 MEXICO_MASK $ROOT/MASKS/v2014-07/BRAVO.MexicoMask.generic.1x1.nc  MASK     2000/1/1/0 C xy unitless 1 -118/17/-95/33
1002 CANADA_MASK $ROOT/MASKS/v2014-07/Canada_mask.geos.1x1.nc          MASK     2000/1/1/0 C xy unitless 1 -141/40/-52/85
1003 SEASIA_MASK $ROOT/MASKS/v2014-07/SE_Asia_mask.generic.1x1.nc      MASK     2000/1/1/0 C xy unitless 1  60/-12/153/55
1004 NA_MASK     $ROOT/MASKS/v2014-07/NA_mask.geos.1x1.nc              MASK     2000/1/1/0 C xy unitless 1 -165/10/-40/90
1005 USA_MASK    $ROOT/MASKS/v2014-07/usa.mask.nei2005.geos.1x1.nc     MASK     2000/1/1/0 C xy unitless 1 -165/10/-40/90
1006 ASIA_MASK   $ROOT/MASKS/v2014-07/MIX_Asia_mask.generic.025x025.nc MASK     2000/1/1/0 C xy unitless 1 46/-12/180/82
1007 NEI11_MASK  $ROOT/MASKS/v2014-07/USA_LANDMASK_NEI2011_0.1x0.1.nc  LANDMASK 2000/1/1/0 C xy 1        1 -140/20/-50/60

### END SECTION MASKS ###

### END OF HEMCO INPUT FILE ###
#EOC