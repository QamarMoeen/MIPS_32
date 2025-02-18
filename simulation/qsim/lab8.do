onerror {exit -code 1}
vlib work
vlog -work work lab8.vo
vlog -work work Waveform2.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.wrapper_vlg_vec_tst -voptargs="+acc"
vcd file -direction lab8.msim.vcd
vcd add -internal wrapper_vlg_vec_tst/*
vcd add -internal wrapper_vlg_vec_tst/i1/*
run -all
quit -f
