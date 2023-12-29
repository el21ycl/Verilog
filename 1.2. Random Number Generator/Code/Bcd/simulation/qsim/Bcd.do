onerror {quit -f}
vlib work
vlog -work work Bcd.vo
vlog -work work Bcd.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Bcd_vlg_vec_tst
vcd file -direction Bcd.msim.vcd
vcd add -internal Bcd_vlg_vec_tst/*
vcd add -internal Bcd_vlg_vec_tst/i1/*
add wave /*
run -all
