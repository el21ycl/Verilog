onerror {quit -f}
vlib work
vlog -work work Random.vo
vlog -work work Random.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Random_vlg_vec_tst
vcd file -direction Random.msim.vcd
vcd add -internal Random_vlg_vec_tst/*
vcd add -internal Random_vlg_vec_tst/i1/*
add wave /*
run -all
