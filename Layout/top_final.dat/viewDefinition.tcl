if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name Max\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tsl18cio150_max.lib\
    ${::IMEX::libVar}/mmmc/tsl18fs120_max.lib\
    ${::IMEX::libVar}/mmmc/dpram4096x32_CB_max.lib]
create_library_set -name Typ\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tsl18cio150_typ.lib\
    ${::IMEX::libVar}/mmmc/tsl18fs120_typ.lib\
    ${::IMEX::libVar}/mmmc/dpram4096x32_CB_typ.lib]
create_library_set -name Min\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tsl18cio150_min.lib\
    ${::IMEX::libVar}/mmmc/tsl18fs120_min.lib\
    ${::IMEX::libVar}/mmmc/dpram4096x32_CB_min.lib]
create_rc_corner -name SlowRC\
   -cap_table ${::IMEX::libVar}/mmmc/TSL_0.18_6M1L.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 125\
   -qx_tech_file ${::IMEX::libVar}/mmmc/SlowRC/qrcTechFile
create_rc_corner -name FastRC\
   -cap_table ${::IMEX::libVar}/mmmc/TSL_0.18_6M1L.CapTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T -40\
   -qx_tech_file ${::IMEX::libVar}/mmmc/SlowRC/qrcTechFile
create_delay_corner -name SlowDC\
   -library_set Max\
   -rc_corner SlowRC
create_delay_corner -name FastDC\
   -library_set Min\
   -rc_corner FastRC
create_constraint_mode -name TypCM\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/TypCM/TypCM.sdc]
create_analysis_view -name FastView -constraint_mode TypCM -delay_corner FastDC -latency_file ${::IMEX::dataVar}/mmmc/views/FastView/latency.sdc
create_analysis_view -name SlowView -constraint_mode TypCM -delay_corner SlowDC -latency_file ${::IMEX::dataVar}/mmmc/views/SlowView/latency.sdc
set_analysis_view -setup [list SlowView] -hold [list FastView]
