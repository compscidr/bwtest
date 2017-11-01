#!/bin/bash
set -x #echo on
rm -f upload.json
rm -f download.json

TESTSERVER="$(grep -Po '(?<=TEST_SERVER = ).*' config.txt)"
if [ -z "${TESTSERVER}" ]; then
	TESTSERVER="p2ptrader.io"
fi
echo "TESTING WITH ${TESTSERVER}";

iperf3 --client ${TESTSERVER} --port 5201 --json --logfile upload.json -O 3 -i 0
iperf3 --client ${TESTSERVER} --port 5201 --json --logfile download.json -O 3 -i 0 -R

PINGSERVER="$(grep -Po '(?<=PING_SERVER = ).*' config.txt)"
if [ -z "${PINGSERVER}" ]; then
	PINGSERVER="www.google.ca"
fi
echo "PINGING WITH ${PINGSERVER}";
PING="$(ping -c 10 ${PINGSERVER} | tail -1 | awk '{print $4}' | cut -d '/' -f 2)"
if [ -z "${PING}" ]; then
	PING=-1.0
fi
php process.php ping=${PING}
