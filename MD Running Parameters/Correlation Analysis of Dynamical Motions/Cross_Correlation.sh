#! /bin/sh

cpptraj << EOF
parm ../sys_sol.prmtop
trajin ../pr1.nc
trajin ../pr2.nc
trajin ../pr3.nc
trajin ../pr4.nc
trajin ../pr5.nc
autoimage
align @CA first
matrix out dccm.dat correl @CA
go
quit
EOF
