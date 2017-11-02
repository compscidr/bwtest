#!/bin/bash
# Used to setup the scripts for running on a real host (non docker version)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get install curl php php-curl cron git build-essential
mkdir /scripts
cp process.php /scripts
cp test.sh /scripts
git clone https://github.com/esnet/iperf.git
cd iperf
./configure
make
make install
cd ..
cp crontab /etc/cron.d/bwtest
