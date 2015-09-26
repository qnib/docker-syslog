FROM qnib/supervisor

ADD etc/yum.repos.d/rsyslog.repo /etc/yum.repos.d/
RUN yum -y install rsyslog rsyslog-kafka
ADD etc/rsyslog.conf /etc/
#ADD etc/rsyslog.d/*.conf.disabled /etc/rsyslog.d/
RUN mv /etc/rsyslog.d/listen.conf /etc/rsyslog.d/listen.conf.disabled
# START
ADD opt/qnib/rsyslog/bin/start_rsyslog.sh /opt/qnib/rsyslog/bin/
ADD etc/supervisord.d/*.ini /etc/supervisord.d/
ADD etc/consul.d/check_rsyslog.json /etc/consul.d/
ADD etc/consul-templates/*.ctmpl /etc/consul-templates/

### consul-template controled rsyslog-config
# if a potential service to send to comes online the config is changed
ADD etc/consul-templates/rsyslog_targets.conf.ctmpl /etc/consul-templates/

