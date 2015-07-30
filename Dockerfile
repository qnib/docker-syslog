FROM qnib/supervisor
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y unzip
# syslog
RUN yum install -y syslog-ng nmap
ADD etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD etc/syslog-ng/conf.d/logstash.conf.disabled /etc/syslog-ng/conf.d/
ADD etc/consul.d/check_syslog-ng.json /etc/consul.d/check_syslog-ng.json
ADD opt/qnib/bin/start_syslog-ng.sh /opt/qnib/bin/start_syslog-ng.sh
ADD etc/supervisord.d/syslog-ng.ini /etc/supervisord.d/

