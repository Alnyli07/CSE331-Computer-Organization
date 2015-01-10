transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Can/Desktop/Yeni\ klasÃ¶r/ozer_alican_111044070_pr4 {C:/Users/Can/Desktop/Yeni klasör/ozer_alican_111044070_pr4/ozer_alican_pr4.v}
vlog -vlog01compat -work work +incdir+C:/Users/Can/Desktop/Yeni\ klasÃ¶r/ozer_alican_111044070_pr4 {C:/Users/Can/Desktop/Yeni klasör/ozer_alican_111044070_pr4/aluModul.v}
vlog -vlog01compat -work work +incdir+C:/Users/Can/Desktop/Yeni\ klasÃ¶r/ozer_alican_111044070_pr4 {C:/Users/Can/Desktop/Yeni klasör/ozer_alican_111044070_pr4/regMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Can/Desktop/Yeni\ klasÃ¶r/ozer_alican_111044070_pr4 {C:/Users/Can/Desktop/Yeni klasör/ozer_alican_111044070_pr4/instMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Can/Desktop/Yeni\ klasÃ¶r/ozer_alican_111044070_pr4 {C:/Users/Can/Desktop/Yeni klasör/ozer_alican_111044070_pr4/dataMemory.v}

