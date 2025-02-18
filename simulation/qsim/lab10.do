onerror {exit -code 1}
vlib work
vlog -work work lab8.vo
vlog -work work datamem2.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.memory_vlg_vec_tst -voptargs="+acc"
vcd file -direction lab10.msim.vcd
vcd add -internal memory_vlg_vec_tst/*
vcd add -internal memory_vlg_vec_tst/i1/*
run -all
quit -f
