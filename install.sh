#!/bin/bash
# Used to setup the scripts for running on a real host (non docker version)
# should be run as root
mkdir /scripts
cp process.php /scripts
cp test.sh /scripts
git clone https://github.com/esnet/iperf.git
cd iperf
./configure
make
make install
cd ..

