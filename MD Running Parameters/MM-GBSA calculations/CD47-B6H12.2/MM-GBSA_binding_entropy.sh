#!/bin/bash
# nohup bash mmgbsa_binding_entropy.sh > mmgbsa_binding_entropy.log 2>&1 &

# Intel
source /opt/intel/bin/compilervars.sh intel64
export MKL_HOME=/opt/intel/mkl

# Amber
export AMBERHOME=/opt/amber20
source $AMBERHOME/amber.sh


########################
# Binding_Entropy
########################
cat > mmgbsa.in << EOF
Input file for running entropy calculations using NMode
&general
	endframe=50000, keep_files=1, entropy=0, 
/
&nmode
	nmstartframe=1, nmendframe=50000, 
	nminterval=1000, nmode_igb=1, nmode_istrng=0.0,
/

EOF

mpirun -np 10 MMPBSA.py.MPI -O -i mmgbsa.in -o FINAL_RESULTS_MMGBSA.dat -sp sys_sol.prmtop -cp dry.prmtop -rp antib.prmtop -lp CD47.prmtop -y ../../md/500ns_second/pr*.nc > mmgbsa_process.log