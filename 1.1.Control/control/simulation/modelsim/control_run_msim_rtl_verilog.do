transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ELEC373/control {D:/ELEC373/control/control.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Bcd7seg_1 {D:/ELEC373/Bcd7seg_1/Bcd7seg_1.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/Bcd7seg_0 {D:/ELEC373/Bcd7seg_0/Bcd7seg_0.v}
vlog -vlog01compat -work work +incdir+D:/ELEC373/count {D:/ELEC373/count/count.v}

