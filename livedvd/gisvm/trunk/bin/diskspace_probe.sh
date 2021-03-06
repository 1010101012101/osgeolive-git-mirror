#!/bin/sh
#   diskspace_probe.sh
#      by Hamish Bowman, 23 June 2013
#   Copyright (c) 2013  Hamish Bowman, and The Open Source Geospatial Foundation
#   Licensed under the GNU LGPL >=2.1.
#   Previously this code existed in OSGeo Live DVD version 4-6's main.sh
#
# PURPOSE: Show how much disk space is free at the start and end of each install script.
#
# USAGE:   diskspace_probe.sh  <project_name> [begin|end]
#		if "begin" or "end" is not given it just does the
#		  df (for mid-script debug, etc).
#


#debug: run this on the chroot:
# df -h --print-type


if [ $# -lt 1 ] || [ $# -gt 2 ] ; then
   echo "USAGE:   diskspace_probe.sh <project_name> [begin|end]" 1>&2
   exit 1
elif [ $# -eq 2 ] && [ "$2" != "begin" -a "$2" != "end" ] ; then
   echo "USAGE:   diskspace_probe.sh <project_name> [begin|end]" 1>&2
   exit 1
fi


do_hr() {
   echo "==============================================================="
}

df_cmd_regular() {
# TODO: check that cd /tmp/build_<project> gives same answer as in original build dir
   echo "Disk Usage1: $1,`df | head -n 1 | sed -e 's/ted on/ted_on/' -e 's/  */,/g'`,date"
   echo "Disk Usage2: $1,`df -B 1M / | tail -n +2 | sed -e 's/  */,/g'`,`date --rfc-3339=seconds`"
}

df_cmd_chroot() {
   echo "Disk Usage1: $1,`df . | head -n 1 | sed -e 's/ted on/ted_on/' -e 's/  */,/g'`,date"
   echo "Disk Usage2: $1,`df -B 1M . | tail -n +2 | sed -e 's/  */,/g'`,`date --rfc-3339=seconds`"
   echo "Temp Usage: $1,`du -s -B 1M /tmp`"
}

df_cmd() {
   df_cmd_chroot "$1"
}

if [ "$2" = "begin" ] ; then
   do_hr
   echo "Starting \"$1\" ..."
   do_hr

elif [ "$2" = "end" ] ; then
   do_hr
   echo "Finished \"$1\""
   df_cmd "$1"
   do_hr

else
   do_hr
   df_cmd "$1"
   do_hr

fi
