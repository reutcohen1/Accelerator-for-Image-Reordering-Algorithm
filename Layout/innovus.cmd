#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Feb 15 17:37:58 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.33-s094_1 (64bit) 08/25/2023 16:48 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.33-s094_1 NR230808-0153/22_13-UB (database version 18.20.615_1) {superthreading v2.20}
#@(#)CDS: AAE 22.13-s029 (64bit) 08/25/2023 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.13-s030_1 () Aug 22 2023 02:51:11 ( )
#@(#)CDS: SYNTECH 22.13-s015_1 () Aug 20 2023 22:21:55 ( )
#@(#)CDS: CPE v22.13-s082
#@(#)CDS: IQuantus/TQuantus 21.2.2-s211 (64bit) Tue Jun 20 22:12:10 PDT 2023 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
getVersion
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
        {-window "window coordinates" "" list optional}
        {-window_size "window size in microns" "" string optional}
    
    }
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
win
set enc_check_rename_command_name 1
set defHierChar /
set fp_core_to_left 30.000000
set fp_core_to_right 30.000000
set init_io_file top.io
set init_oa_search_lib {}
set conf_ioOri R0
set init_verilog top.v
set init_pwr_net {VDD VDDC VDDO}
set init_mmmc_file mmmc.view
set delaycal_input_transition_delay 120ps
set init_assign_buffer 1
set init_lef_file {/users/iit/cadence/tsl018b/lef/tsl18_6lm_tech.lef /users/iit/cadence/tsl018b/lef/tsl18cio150_6lm.lef /users/iit/cadence/tsl018b/lef/tsl18fs120.lef}
set init_top_cell top
set conf_in_tran_delay 120.0ps
setImportMode -keepEmptyModule 0 -treatUndefinedCellAsBbox 0
set init_import_mode { -keepEmptyModule 0 -treatUndefinedCellAsBbox 0}
set fp_core_height 257.600000
set fpIsMaxIoHeight 0
set fp_core_to_top 30.000000
set fp_core_width 389.700000
set init_layout_view layout
set init_gnd_net {VSS VSSC VSSO}
set conf_row_height 5.600000
set init_abstract_view abstract
set fp_core_to_bottom 30.000000
set defHierChar /
set fp_core_to_left 30.000000
set fp_core_to_right 30.000000
set init_io_file top.io
set init_oa_search_lib {}
set conf_ioOri R0
set init_verilog top.v
set init_pwr_net {VDD VDDC VDDO}
set init_mmmc_file mmmc.view
set delaycal_input_transition_delay 120ps
set init_assign_buffer 1
set init_lef_file {/users/iit/cadence/tsl018b/lef/tsl18_6lm_tech.lef /users/iit/cadence/tsl018b/lef/tsl18cio150_6lm.lef /users/iit/cadence/tsl018b/lef/tsl18fs120.lef}
set init_top_cell top
set conf_in_tran_delay 120.0ps
setImportMode -keepEmptyModule 0 -treatUndefinedCellAsBbox 0
set init_import_mode { -keepEmptyModule 0 -treatUndefinedCellAsBbox 0}
set fp_core_height 257.600000
set fpIsMaxIoHeight 0
set fp_core_to_top 30.000000
set fp_core_width 389.700000
set init_layout_view layout
set init_gnd_net {VSS VSSC VSSO}
set conf_row_height 5.600000
set init_abstract_view abstract
set fp_core_to_bottom 30.000000
init_design
setDrawView fplan
zoomBox -713.02700 -128.63600 1261.99600 826.21600
zoomBox -1000.15300 -236.57000 1323.40300 886.78500
zoomBox -713.02700 -128.63600 1261.99600 826.21600
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.995606752964 0.699998 50 50 50 50
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.995065789474 0.699618 50.4 50.4 50.4 50.4
uiSetTool select
getIoFlowFlag
fit
zoomBox -635.22500 -75.75600 1448.36900 931.58600
zoomBox -494.64800 -38.92100 1276.40700 817.32000
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.995065789474 0.699618 50.4 50.4 50.4 50.4
uiSetTool select
getIoFlowFlag
fit
zoomBox -545.01400 -112.02700 1538.57900 895.31400
zoomBox -603.82700 -197.37300 1847.45900 987.73500
zoomBox -673.02000 -297.78000 2210.84700 1096.46500
zoomBox -754.42300 -415.90500 2638.36200 1224.38300
zoomBox -850.55100 -554.87600 3140.96100 1374.87500
zoomBox -374.96000 601.85100 261.11900 909.37200
zoomBox -447.58800 561.42000 300.74000 923.20900
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDDC -type pgpin -pin VDDC -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDDC -type pgpin -pin VDDC -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDDC -type pgpin -pin VDDC -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSSC -type pgpin -pin VSSC -instanceBasename * -hierarchicalInstance {}
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDDC -type pgpin -pin VDDC -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSSC -type pgpin -pin VSSC -instanceBasename * -hierarchicalInstance {}
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -hierarchicalInstance {}
zoomBox -165.42600 16.04900 1114.16000 634.68200
zoomBox -36.85200 37.51600 1050.79600 563.35400
zoomBox 288.96100 86.40400 956.91400 409.33500
gui_select -rect {789.42400 159.10400 750.46300 144.64400}
zoomBox 131.99800 67.51100 1056.50200 514.47500
setDrawView ameba
setDrawView place
zoomBox -150.76900 -32.92500 1128.82300 585.71100
zoomBox -330.27700 -96.60900 1175.12600 631.19900
setDrawView place
setDrawView ameba
setDrawView fplan
zoomBox -173.71800 -68.63700 1105.87600 550.00000
gui_select -rect {818.10200 76.01900 638.05100 -47.09300}
setPreference ConstraintUserYGrid 0.01
setPreference ConstraintUserXGrid 0.01
globalNetConnect VDD -type pgpin -pin VDD -inst * -module {}
globalNetConnect VSS -type pgpin -pin VSS -inst * -module {}
globalNetConnect VSSC -type pgpin -pin VSSC -inst * -module {}
globalNetConnect VDDC -type pgpin -pin VDDC -inst * -module {}
globalNetConnect VDD -type tiehi -module {}
globalNetConnect VSS -type tielo -module {}
snapFPlanIO -userGrid
zoomBox -331.50000 -134.90000 1173.90400 592.90800
zoomBox -516.96700 -212.21800 1254.09700 644.02700
zoomBox -173.85500 -69.61300 1105.74100 549.02500
addIoFiller -cell pfeed30000 -prefix pfeed
addIoFiller -cell pfeed10000 -prefix pfeed
addIoFiller -cell pfeed02000 -prefix pfeed
addIoFiller -cell pfeed01000 -prefix pfeed
addIoFiller -cell pfeed00540 -prefix pfeed
addIoFiller -cell pfeed00120 -prefix pfeed
addIoFiller -cell pfeed00040 -prefix pfeed
addIoFiller -cell pfeed00010 -prefix pfeed
zoomBox -349.29000 -149.99900 1156.11700 577.81100
setDrawView ameba
setDrawView place
setDrawView ameba
setDrawView fplan
deselectAll
selectObject Module u_controller
zoomBox -468.20000 -232.40100 1615.41100 774.94900
zoomBox -543.81900 -284.80300 1907.48900 900.31500
zoomBox -632.78100 -346.45200 2251.11100 1047.80500
zoomBox -737.44200 -418.98000 2655.37200 1221.32200
zoomBox -860.57300 -504.30700 3130.97300 1425.46000
panPage -1 0
panPage 1 0
deselectAll
selectObject Module u_image_buffer
zoomBox -544.74600 -3.24400 1906.56400 1181.87500
zoomBox -342.25800 301.90900 1163.15400 1029.72100
zoomBox -626.57600 -129.12600 2257.32000 1265.13300
zoomBox -855.03600 -475.47700 3136.51800 1454.29400
zoomBox -1000.32000 -695.73200 3695.62600 1574.58700
deselectAll
selectObject Module u_reordering
deselectAll
selectObject Module u_hash_calc
zoomBox -746.43400 -483.37700 2646.38700 1156.92900
zoomBox -560.92100 -328.65000 1890.39300 856.47100
zoomBox -345.00100 -151.75600 1160.41200 576.05600
zoomBox -476.42700 -256.57000 1607.19000 750.78300
zoomBox -598.58100 -547.81700 2285.31800 846.44300
zoomBox -675.08800 -731.43300 2717.73400 908.87300
zoomBox -751.41500 -932.33100 3240.14100 997.44100
panPage -1 0
zoomBox -1492.02200 -573.99200 959.29400 611.13000
zoomBox -1383.90200 -486.43500 699.71700 520.91900
zoomBox -1295.57100 -407.87600 475.50600 448.37500
zoomBox -1220.48900 -341.10100 284.92600 386.71200
zoomBox -1295.57100 -407.87600 475.50600 448.37500
zoomBox -1383.90300 -486.43500 699.71800 520.92000
zoomBox -1487.60100 -579.74100 963.71700 605.38200
zoomBox -1609.59900 -689.51400 1274.30500 704.74900
zoomBox -1753.12800 -818.65800 1639.70200 821.65200
zoomBox -1572.57300 -652.79100 1311.33400 741.47300
zoomBox -1419.10100 -511.80400 1032.22100 673.32100
deselectAll
selectObject Module u_reordering
zoomBox -1572.05400 -650.97100 1311.85400 743.29400
zoomBox -1752.00000 -814.39000 1640.83500 825.92200
deselectAll
selectObject Module u_reordering
deselectAll
selectObject Module u_reordering
deselectAll
zoomBox -1404.35200 -651.89000 1479.55800 742.37600
zoomBox -1625.00000 -669.02800 1767.83700 971.28500
zoomBox -1396.70300 -627.10300 1487.20900 767.16400
zoomBox -1202.65100 -590.68600 1248.67500 594.44100
panPage 0 1
zoomBox -1359.24700 -275.98800 1524.66800 1118.28000
zoomBox -1542.55800 -323.11600 1850.28300 1317.19900
getIoFlowFlag
setLayerPreference node_cell -isVisible 1
setLayerPreference node_row -isVisible 1
setLayerPreference node_floorplan -isVisible 1
setLayerPreference node_power -isVisible 1
zoomBox -922.05400 -221.20900 1529.27400 963.91900
zoomBox -468.86500 -146.73000 1302.22000 709.52500
zoomBox 144.04100 -51.53600 1068.56100 395.43600
zoomBox 244.44300 -35.69200 1030.28500 344.23400
zoomBox 329.78300 -22.22500 997.75100 300.71300
zoomBox 516.08100 6.55900 926.30000 204.88500
gui_select -rect {798.03000 68.47400 744.25500 32.70600}
zoomBox 460.75300 -1.10300 943.36400 232.22200
zoomBox 319.08300 -20.72000 987.05700 302.22100
setLayerPreference node_overlay -isVisible 1
setLayerPreference congestH -color {#000066 #0000c9 #0053ff #00fcfa #00a953 #53a900 #f9fc00 #ff5300 #ff5858 #ffffff}
setLayerPreference congestV -color {#000066 #0000c9 #0053ff #00fcfa #00a953 #53a900 #f9fc00 #ff5300 #ff5858 #ffffff}
fit
setLayerPreference node_track -isVisible 1
setLayerPreference node_gird -isVisible 1
