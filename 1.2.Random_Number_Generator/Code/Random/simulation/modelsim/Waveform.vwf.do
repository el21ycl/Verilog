vlog -work work D:/ELEC373/Assigment_2/Random/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Random_vlg_vec_tst
onerror {resume}
add wave {Random_vlg_vec_tst/i1/R}
add wave {Random_vlg_vec_tst/i1/R[7]}
add wave {Random_vlg_vec_tst/i1/R[6]}
add wave {Random_vlg_vec_tst/i1/R[5]}
add wave {Random_vlg_vec_tst/i1/R[4]}
add wave {Random_vlg_vec_tst/i1/R[3]}
add wave {Random_vlg_vec_tst/i1/R[2]}
add wave {Random_vlg_vec_tst/i1/R[1]}
add wave {Random_vlg_vec_tst/i1/R[0]}
add wave {Random_vlg_vec_tst/i1/R_b}
add wave {Random_vlg_vec_tst/i1/R_b[7]}
add wave {Random_vlg_vec_tst/i1/R_b[6]}
add wave {Random_vlg_vec_tst/i1/R_b[5]}
add wave {Random_vlg_vec_tst/i1/R_b[4]}
add wave {Random_vlg_vec_tst/i1/R_b[3]}
add wave {Random_vlg_vec_tst/i1/R_b[2]}
add wave {Random_vlg_vec_tst/i1/R_b[1]}
add wave {Random_vlg_vec_tst/i1/R_b[0]}
add wave {Random_vlg_vec_tst/i1/clk}
add wave {Random_vlg_vec_tst/i1/rst}
add wave {Random_vlg_vec_tst/i1/start}
run -all
