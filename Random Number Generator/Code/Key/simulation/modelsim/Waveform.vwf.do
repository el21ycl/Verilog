vlog -work work D:/ELEC373/Assigment_2/Key/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Key_vlg_vec_tst
onerror {resume}
add wave {Key_vlg_vec_tst/i1/Key_0}
add wave {Key_vlg_vec_tst/i1/Key_2}
add wave {Key_vlg_vec_tst/i1/Z}
add wave {Key_vlg_vec_tst/i1/Z[3]}
add wave {Key_vlg_vec_tst/i1/Z[2]}
add wave {Key_vlg_vec_tst/i1/Z[1]}
add wave {Key_vlg_vec_tst/i1/Z[0]}
add wave {Key_vlg_vec_tst/i1/clk}
add wave {Key_vlg_vec_tst/i1/rst}
add wave {Key_vlg_vec_tst/i1/start}
run -all
