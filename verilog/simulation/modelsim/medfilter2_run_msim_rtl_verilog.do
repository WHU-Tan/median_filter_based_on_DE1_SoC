transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/singal2/final_project/verilog {C:/singal2/final_project/verilog/win3by3_gen.v}
vlog -vlog01compat -work work +incdir+C:/singal2/final_project/verilog {C:/singal2/final_project/verilog/medfilter3by3.v}
vlog -vlog01compat -work work +incdir+C:/singal2/final_project/verilog {C:/singal2/final_project/verilog/medfilter2.v}
vlog -vlog01compat -work work +incdir+C:/singal2/final_project/verilog {C:/singal2/final_project/verilog/counter_ctrl.v}

