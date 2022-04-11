transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3_256/flipflop64.vhd}
vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3_256/theta_stage.vhd}

vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3_256/theta_stage_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  theta_stage_tb

add wave *
view structure
view signals
run 200 ns
