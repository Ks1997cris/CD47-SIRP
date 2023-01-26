#! /bin/bash

cpptraj <<EOF
parm ../sys_sol.prmtop
trajin ../pr1.nc
trajin ../pr2.nc
trajin ../pr3.nc
trajin ../pr4.nc
trajin ../pr5.nc
strip :WAT
autoimage
rms first @CA
average crdset rmsf_average
run
rms ref rmsf_average @CA
atomicfluct out rmsf_CA.dat @CA
EOF