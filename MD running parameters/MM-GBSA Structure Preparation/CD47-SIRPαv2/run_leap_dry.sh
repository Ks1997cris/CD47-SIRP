#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

dry = loadpdb 2jjs_complete_dry.pdb
bond dry.25.SG dry.91.SG
bond dry.139.SG dry.212.SG

set default PBRadii mbondi2

saveamberparm dry dry.prmtop dry.inpcrd
savepdb dry 2jjs_dry_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
