#!/bin/sh
#################################################
# 
# Purpose: Installation of Kosmo into Xubuntu
# Author:  Sergio Banos Calvo <sbc@saig.es> - SAIG <info@saig.es>
#
#################################################
# Copyright (c) 2010 Open Source Geospatial Foundation (OSGeo)
# Copyright (c) 2010 SAIG
#
# Licensed under the GNU GPL.
# 
# This library is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 2.1 of the License,
# or any later version.  This library is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY, without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details, either
# in the "LICENSE.GPL.txt" file distributed with this software or at
# web page "http://www.fsf.org/licenses/gpl.html".
##################################################

# About:
# =====
# This script will install Kosmo 3.0 into Xubuntu

# Running:
# =======
# sudo ./install_kosmo.sh

SCRIPT="install_kosmo.sh"
echo "==============================================================="
echo "$SCRIPT"
echo "==============================================================="

if [ -z "$USER_NAME" ] ; then
   USER_NAME="user"
fi
TMP="/tmp/build_kosmo"
INSTALL_FOLDER="/usr/lib"
KOSMO_FOLDER="$INSTALL_FOLDER/Kosmo-3.0"
BIN="/usr/bin"
USER_HOME="/home/$USER_NAME"

## Setup things... ##

# check required tools are installed
if [ ! -x "`which wget`" ] ; then
   echo "ERROR: wget is required, please install it and try again" 
   exit 1
fi
# create tmp folders
mkdir -p "$TMP"
cd "$TMP"

## Install Application ##

# get kosmo
wget -c --progress=dot:mega \
   http://88.198.230.145/public/kosmo/v_3.0/livedvd/kd_3.0_linux_x86.tar.gz

# unpack it and copy it to /usr/lib
tar xzf kd_3.0_linux_x86.tar.gz \
   -C "$INSTALL_FOLDER" --no-same-owner

if [ $? -ne 0 ] ; then
   echo "ERROR: Kosmo download failed."
   exit 1
fi

adduser "$USER_NAME" users
chgrp -R users "$KOSMO_FOLDER"
chmod -R g+w "$KOSMO_FOLDER"

## execute the links.sh script
cd "$KOSMO_FOLDER"/libs
./links.sh
cd "$TMP"

# get correct kosmo.sh
rm "$KOSMO_FOLDER"/bin/Kosmo.sh
wget -nv -N http://88.198.230.145/public/kosmo/v_3.0/livedvd/Kosmo.sh
cp Kosmo.sh "$KOSMO_FOLDER"/bin/
chmod a+x "$KOSMO_FOLDER"/bin/Kosmo.sh

# create link to startup script
ln -s "$KOSMO_FOLDER"/bin/Kosmo.sh /usr/bin/kosmo_3.0

# Download desktop link
wget -nv http://88.198.230.145/public/kosmo/v_3.0/livedvd/Kosmo_3.0.desktop

# homogenize icon name
sed -i -e 's/^Name=Kosmo_3.0/Name=Kosmo/' Kosmo_3.0.desktop

# copy it into the Kosmo_3.0 folder
cp Kosmo_3.0.desktop "$USER_HOME"/Desktop
chown "$USER_NAME:$USER_NAME" "$USER_HOME"/Desktop/Kosmo_3.0.desktop
chmod a+r "$USER_HOME"/Desktop/Kosmo_3.0.desktop

# fix #1147 - Unnecesary, new Kosmo Desktop package doesn't contain them
# rm -f "$KOSMO_FOLDER"/libs/*NCS*
# rm -f "$KOSMO_FOLDER"/libs/*ecw*
# rm -f "$KOSMO_FOLDER"/libs/*mrsid*

echo "==============================================================="
echo "Finished $SCRIPT"
echo Disk Usage1:, $SCRIPT, `df . -B 1M | grep "Filesystem" | sed -e "s/  */,/g"`, date
echo Disk Usage2:, $SCRIPT, `df . -B 1M | grep " /$" | sed -e "s/  */,/g"`, `date`
echo "==============================================================="