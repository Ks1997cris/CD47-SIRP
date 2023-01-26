#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

antib = loadpdb 5tzu_complete_antibody.pdb
bond antib.23.SG antib.88.SG
bond antib.134.SG antib.194.SG
bond antib.235.SG antib.309.SG
bond antib.358.SG antib.414.SG

set default PBRadii mbondi2

saveamberparm antib antib.prmtop antib.inpcrd
savepdb antib antib_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
