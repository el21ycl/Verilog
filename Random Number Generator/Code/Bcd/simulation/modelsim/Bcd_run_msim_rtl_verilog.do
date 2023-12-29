transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ELEC373/Assigment_2/Bcd {D:/ELEC373/Assigment_2/Bcd/Bcd.v}

