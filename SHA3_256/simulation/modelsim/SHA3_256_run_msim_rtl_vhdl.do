transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/flipflop64.vhd}
vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/theta_stage.vhd}
vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/rho_pi_stage.vhd}
vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/chi_iota_stage.vhd}
vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/SHA3_256.vhd}

vcom -93 -work work {C:/Users/jack_/Documents/Rowan/Complex_Digital_Systems/SHA3-256 VHDL Project/SHA3_256/SHA3_256_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  SHA3_256_tb

add wave *
view structure
view signals
run -all
