#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

dry = loadpdb 4cmm_complete_dry.pdb
bond dry.25.SG dry.91.SG
bond dry.142.SG dry.215.SG

set default PBRadii mbondi2

saveamberparm dry dry.prmtop dry.inpcrd
savepdb dry 4cmm_dry_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
