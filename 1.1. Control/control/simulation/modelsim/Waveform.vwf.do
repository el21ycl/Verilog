vlog -work work D:/ELEC373/control/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.control_vlg_vec_tst
onerror {resume}
add wave {control_vlg_vec_tst/i1/Key_0}
add wave {control_vlg_vec_tst/i1/Key_2}
add wave {control_vlg_vec_tst/i1/clk}
add wave {control_vlg_vec_tst/i1/hex4}
add wave {control_vlg_vec_tst/i1/hex4[6]}
add wave {control_vlg_vec_tst/i1/hex4[5]}
add wave {control_vlg_vec_tst/i1/hex4[4]}
add wave {control_vlg_vec_tst/i1/hex4[3]}
add wave {control_vlg_vec_tst/i1/hex4[2]}
add wave {control_vlg_vec_tst/i1/hex4[1]}
add wave {control_vlg_vec_tst/i1/hex4[0]}
add wave {control_vlg_vec_tst/i1/hex5}
add wave {control_vlg_vec_tst/i1/hex5[6]}
add wave {control_vlg_vec_tst/i1/hex5[5]}
add wave {control_vlg_vec_tst/i1/hex5[4]}
add wave {control_vlg_vec_tst/i1/hex5[3]}
add wave {control_vlg_vec_tst/i1/hex5[2]}
add wave {control_vlg_vec_tst/i1/hex5[1]}
add wave {control_vlg_vec_tst/i1/hex5[0]}
add wave {control_vlg_vec_tst/i1/rst}
run -all
