#!/bin/sh

# (C) British Crown Copyright 2010 - 2013, Met Office
# Licensed under the GNU LGPL.
#
# Iris is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Iris is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Iris. If not, see <http://www.gnu.org/licenses/>.
#
# About:
# =====
# This script will install Iris

./diskspace_probe.sh "`basename $0`" begin
BUILD_DIR=`pwd`
####

apt-get install -y python-dev netcdf-bin libhdf5-serial-dev libnetcdf-dev \
    libudunits2-dev libgeos-dev libproj-dev libjasper-dev libfreetype6-dev \
    libpng-dev tk-dev python-tk cython python-scipy  python-nose python-pyke \
    python-mock python-sphinx python-shapely python-pip

# Install additional python packages using pip:
pip install netCDF4 pyshp

## in any case, matplotlib is required
if [ ! -e /usr/share/pyshared/matplotlib ] ; then
    ## closed in tickets #1271 #1285 commentary/attachments
    #apt-get install -y python-matplotlib
    #   -> matplotlib 1.1.1rc

    #pip install matplotlib
    pip install --upgrade matplotlib
    #   -> matplotlib 1.3.1
fi

# Build and install grib_api (optional):
mkdir /tmp/build_iris
cd /tmp/build_iris

wget --no-check-certificate -c --progress=dot:mega \
  "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.9.16.tar.gz"

tar xzf grib_api-1.9.16.tar.gz

cd grib_api-1.9.16
./configure --enable-python
make
make install

echo "/usr/local/lib/python2.7/site-packages/grib_api" > gribapi.pth
cp gribapi.pth /usr/local/lib/python2.7/dist-packages/

# Build and install the PP packing library (optional):
cd /tmp/build_iris
wget -c -nv \
  "https://puma.nerc.ac.uk/trac/UM_TOOLS/raw-attachment/wiki/unpack/unpack-030712.tgz"

tar xzf "unpack-030712.tgz"

cd unpack-030712
cd libmo_unpack

wget -c -nv \
  "https://raw.github.com/scitools/installation-recipes/master/xubuntu12.04/unpack-030712_xubuntu.patch"

patch -p2 < "unpack-030712_xubuntu.patch"

bash ./make_library
./distribute.sh /usr/local

ldconfig

# Install Cartopy dependancy: (6 MB)
cd /tmp/build_iris
wget --progress=dot:mega -O cartopy.zip \
  "https://github.com/SciTools/cartopy/archive/v0.8.0.zip"
unzip -q cartopy.zip

cd cartopy-0.8.0
python setup.py install

# Install Iris: (3.5 MB)
cd /tmp/build_iris
wget --progress=dot:mega -O iris.zip \
  "https://github.com/SciTools/iris/archive/v1.4.0.zip"

unzip -q iris.zip

cd iris-1.4.0
python setup.py --with-unpack install
touch /usr/local/lib/python2.7/dist-packages/Iris-1.4.0-py2.7-linux-i686.egg/iris/fileformats/_pyke_rules/compiled_krb/*

# Tidy up
apt-get --yes remove python-dev libhdf5-serial-dev libnetcdf-dev \
               libgeos-dev libproj-dev \
	       libjasper-dev libfreetype6-dev libpng-dev tk-dev

rm -rf /usr/local/lib/python2.7/dist-packages/cartopy/data \
       /usr/local/lib/python2.7/dist-packages/cartopy/examples \
       /usr/local/lib/python2.7/dist-packages/cartopy/sphinxext \
       /usr/local/lib/python2.7/dist-packages/cartopy/tests \
       /usr/local/lib/python2.7/dist-packages/Iris-1.4.0-py2.7-linux-i686.egg/iris/tests

cd "$BUILD_DIR"
rm -rf /tmp/build_iris


####
"$BUILD_DIR"/diskspace_probe.sh "`basename $0`" end
