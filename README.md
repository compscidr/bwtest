There are two ways to run this tool. 

First, natively in the operating
system. You can perform one-off runs, or by using the crontab provided.
If you run with the crontab provided, you must update the crontab with
the location of the test.sh and process.php scripts. Alternatively you
can move the test.sh and process.php scripts to the /scripts folder.

The second way of running is via a docker container. The Dockerfile
is already defined and will obtain all the necessary dependencies for
running. Note - the way the image was setup, any changes to config.txt
will not be reflected once the container is built (it is not a shared
volume, just added to the image - so if you change this file you'll
need to perform a rebuild).

requires:
- curl
- php
- php-curl
- iperf3 (version 3.1 or higher so that it has the --logfile param)
- git to checkout iperf3
- build-essential to build iperf3
