#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

dry = loadpdb 5tzu_complete_dry.pdb
bond dry.23.SG dry.88.SG
bond dry.134.SG dry.194.SG
bond dry.235.SG dry.309.SG
bond dry.358.SG dry.414.SG
bond dry.456.SG dry.529.SG

set default PBRadii mbondi2

saveamberparm dry dry.prmtop dry.inpcrd
savepdb dry 5tzu_dry_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
