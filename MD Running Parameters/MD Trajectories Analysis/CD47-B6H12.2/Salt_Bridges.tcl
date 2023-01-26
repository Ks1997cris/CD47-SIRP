#!vmd
# usage: nohup vmd -dispdev text -e saltbr.tcl > vmd.log 2>&1 &

file mkdir saltbridges

mol new ../sys_sol.prmtop type parm7 waitfor all

mol addfile ../pr1.nc waitfor all
mol addfile ../pr2.nc waitfor all
mol addfile ../pr3.nc waitfor all
mol addfile ../pr4.nc waitfor all
mol addfile ../pr5.nc waitfor all

package require saltbr

saltbr -sel [atomselect top protein] -log saltbridges.log -outdir ./saltbridges

exit