#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB
source leaprc.water.tip3p

sys = loadpdb 5tzu_fixed_complete.pdb
bond sys.23.SG sys.88.SG
bond sys.134.SG sys.194.SG
bond sys.235.SG sys.309.SG
bond sys.358.SG sys.414.SG
bond sys.456.SG sys.529.SG

solvateoct sys TIP3PBOX 12.0 iso
addions2 sys Na+ 0
addions2 sys Cl- 0

saveamberparm sys sys_sol.prmtop sys_sol.inpcrd
savepdb sys sys_sol.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
