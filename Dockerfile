FROM ubuntu:20.04

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    curl php php-cli php-curl cron git build-essential

ADD . /scripts/
RUN git clone https://github.com/esnet/iperf.git /scripts/
RUN /scripts/configure
RUN /scripts/make
RUN /scripts/make install

ADD crontab /etc/cron.d/bwtest
RUN chmod 0644 /etc/cron.d/bwtest
RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log

