FROM qnib/supervisor
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    curl -Ls -o /etc/yum.repos.d/czanik-syslog-ng36-epel-7.repo https://copr.fedoraproject.org/coprs/czanik/syslog-ng36/repo/epel-7/czanik-syslog-ng36-epel-7.repo
RUN yum install -y unzip syslog-ng nmap syslog-ng-incubator-kafka syslog-ng-incubator-grok syslog-ng-json
ADD etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD etc/syslog-ng/conf.d/*.conf.disabled /etc/syslog-ng/conf.d/
ADD etc/consul.d/check_syslog-ng.json /etc/consul.d/check_syslog-ng.json
ADD opt/qnib/bin/start_syslog-ng.sh /opt/qnib/bin/start_syslog-ng.sh
ADD etc/supervisord.d/syslog-ng.ini /etc/supervisord.d/

