#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

CD47 = loadpdb 2jjs_complete_cd47.pdb
bond CD47.23.SG CD47.96.SG

set default PBRadii mbondi2

saveamberparm CD47 CD47.prmtop CD47.inpcrd
savepdb CD47 CD47_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
