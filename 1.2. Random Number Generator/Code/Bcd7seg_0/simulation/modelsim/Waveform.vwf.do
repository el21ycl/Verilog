vlog -work work D:/ELEC373/Assigment_2/Bcd7seg_0/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Bcd7seg_0_vlg_vec_tst
onerror {resume}
add wave {Bcd7seg_0_vlg_vec_tst/i1/A}
add wave {Bcd7seg_0_vlg_vec_tst/i1/A[3]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/A[2]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/A[1]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/A[0]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[6]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[5]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[4]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[3]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[2]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[1]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/hex4[0]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/test}
add wave {Bcd7seg_0_vlg_vec_tst/i1/test[3]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/test[2]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/test[1]}
add wave {Bcd7seg_0_vlg_vec_tst/i1/test[0]}
run -all
