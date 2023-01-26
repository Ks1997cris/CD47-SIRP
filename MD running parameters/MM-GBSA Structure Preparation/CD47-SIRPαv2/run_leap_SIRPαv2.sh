#!/bin/bash
cat > leap.in << EOF
source leaprc.protein.ff14SB

sirpa = loadpdb 2jjs_complete_sirpalpha.pdb
bond sirpa.25.SG sirpa.91.SG

set default PBRadii mbondi2

saveamberparm sirpa sirpa.prmtop sirpa.inpcrd
savepdb sirpa sirpa_leap.pdb

quit
EOF

tleap -s -f leap.in > leap_out.log
