transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/top_dut.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/sumtwo.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/stateMachOperateSignals.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/StateMachineGenDir2.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/StateMachineGenDir1.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/simple_dual_port_ram.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/prodtwo.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/prescaler.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/contadorDirRamOut.v}
vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03 {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/acum.v}

vlog -vlog01compat -work work +incdir+/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/testbenches {/home/jhonatang/Documentos/PROYECTOS_QUARTUS/PROYECTO_32X32MAT/PROYECT_03/testbenches/tb_dut.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_dut

add wave *
view structure
view signals
run -all
