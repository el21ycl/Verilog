vlog -work work D:/ELEC373/Assigment_2/Time/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Time_vlg_vec_tst
onerror {resume}
add wave {Time_vlg_vec_tst/i1/Key_0}
add wave {Time_vlg_vec_tst/i1/clk}
add wave {Time_vlg_vec_tst/i1/rst}
add wave {Time_vlg_vec_tst/i1/t}
run -all
