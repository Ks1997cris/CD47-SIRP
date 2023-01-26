#!/bin/bash
# nohup bash mmgbsa_per_res_decomp.sh > mmgbsa_per_res_decomp.log 2>&1 &

# Intel
source /opt/intel/bin/compilervars.sh intel64
export MKL_HOME=/opt/intel/mkl

# Amber
export AMBERHOME=/opt/amber20
source $AMBERHOME/amber.sh


########################
# MMGBSA_DECOMP
########################
cat > mmgbsa.in << EOF
Per-residue GB decomposition
&general
	startframe=1, endframe=50000, interval=5, 
	verbose=1, keep_files=0, 
	debug_printlevel=2, 
/
&gb
	igb=2, saltcon=0, 
/
&decomp
	idecomp=1, print_res="1-116; 117-232", csv_format=0, 
	dec_verbose=1, 
/

EOF

mpirun -np 4 MMPBSA.py.MPI -O -i mmgbsa.in -o FINAL_RESULTS_MMGBSA.dat -do FINAL_DECOMP_MMGBSA.dat -sp sys_sol.prmtop -cp dry.prmtop -rp sirpa.prmtop -lp CD47.prmtop -y ../../md/500ns/pr*.nc > mmgbsa_process.log