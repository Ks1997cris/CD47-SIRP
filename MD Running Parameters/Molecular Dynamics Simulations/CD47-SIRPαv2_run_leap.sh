#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p

sys = loadpdb 2jjs_fixed_complete.pdb
bond sys.25.SG sys.91.SG
bond sys.139.SG sys.212.SG

solvateoct sys TIP3PBOX 12.0 iso
addions2 sys Na+ 0
addions2 sys Cl- 0

saveamberparm sys sys_sol.prmtop sys_sol.inpcrd
savepdb sys sys_sol.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
