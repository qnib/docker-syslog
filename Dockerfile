FROM qnib/supervisor
MAINTAINER "Christian Kniep <christian@qnib.org>"

ADD etc/yum.repos.d/rsyslog.repo /etc/yum.repos.d/
RUN yum -y install rsyslog
ADD etc/rsyslog.conf /etc/
ADD etc/rsyslog.d/*.conf.disabled /etc/rsyslog.d/
# START
ADD opt/qnib/rsyslog/bin/start_rsyslog.sh /opt/qnib/rsyslog/bin/
ADD etc/consul.d/check_rsyslog.json /etc/consul.d/
ADD etc/supervisord.d/rsyslog.ini /etc/supervisord.d/

