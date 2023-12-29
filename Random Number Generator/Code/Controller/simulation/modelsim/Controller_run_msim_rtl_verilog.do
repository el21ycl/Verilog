transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Controller {D:/ELEC373/Assigment_2/Controller/Controller.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Key {D:/ELEC373/Assigment_2/Key/Key.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Time {D:/ELEC373/Assigment_2/Time/Time.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Random {D:/ELEC373/Assigment_2/Random/Random.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Number {D:/ELEC373/Assigment_2/Number/Number.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Bcd {D:/ELEC373/Assigment_2/Bcd/Bcd.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Bcd7seg_0 {D:/ELEC373/Assigment_2/Bcd7seg_0/Bcd7seg_0.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Bcd7seg_1 {D:/ELEC373/Assigment_2/Bcd7seg_1/Bcd7seg_1.v}

