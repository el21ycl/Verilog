vlog -work work D:/ELEC373/Assigment_2/Bcd/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Bcd_vlg_vec_tst
onerror {resume}
add wave {Bcd_vlg_vec_tst/i1/R_n}
add wave {Bcd_vlg_vec_tst/i1/R_n[7]}
add wave {Bcd_vlg_vec_tst/i1/R_n[6]}
add wave {Bcd_vlg_vec_tst/i1/R_n[5]}
add wave {Bcd_vlg_vec_tst/i1/R_n[4]}
add wave {Bcd_vlg_vec_tst/i1/R_n[3]}
add wave {Bcd_vlg_vec_tst/i1/R_n[2]}
add wave {Bcd_vlg_vec_tst/i1/R_n[1]}
add wave {Bcd_vlg_vec_tst/i1/R_n[0]}
add wave {Bcd_vlg_vec_tst/i1/clk}
add wave {Bcd_vlg_vec_tst/i1/d_0}
add wave {Bcd_vlg_vec_tst/i1/d_0[3]}
add wave {Bcd_vlg_vec_tst/i1/d_0[2]}
add wave {Bcd_vlg_vec_tst/i1/d_0[1]}
add wave {Bcd_vlg_vec_tst/i1/d_0[0]}
add wave {Bcd_vlg_vec_tst/i1/d_1}
add wave {Bcd_vlg_vec_tst/i1/d_1[3]}
add wave {Bcd_vlg_vec_tst/i1/d_1[2]}
add wave {Bcd_vlg_vec_tst/i1/d_1[1]}
add wave {Bcd_vlg_vec_tst/i1/d_1[0]}
add wave {Bcd_vlg_vec_tst/i1/rst}
add wave {Bcd_vlg_vec_tst/i1/test}
add wave {Bcd_vlg_vec_tst/i1/test[7]}
add wave {Bcd_vlg_vec_tst/i1/test[6]}
add wave {Bcd_vlg_vec_tst/i1/test[5]}
add wave {Bcd_vlg_vec_tst/i1/test[4]}
add wave {Bcd_vlg_vec_tst/i1/test[3]}
add wave {Bcd_vlg_vec_tst/i1/test[2]}
add wave {Bcd_vlg_vec_tst/i1/test[1]}
add wave {Bcd_vlg_vec_tst/i1/test[0]}
run -all
