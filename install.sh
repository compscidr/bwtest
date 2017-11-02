#!/bin/bash
# Used to setup the scripts for running on a real host (non docker version)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get install curl php5-cli php5-curl cron git build-essential
apt-get install --reinstall iputils-ping
git clone https://github.com/esnet/iperf.git
cd iperf
./configure
make
make install
cd ..

dir=$(pwd);
echo "9,19,29,39,49,59 * * * * root cd $dir && ./test.sh >> /var/log/cron.log 2>&1 \n" > crontab
cp crontab /etc/cron.d/bwtest
