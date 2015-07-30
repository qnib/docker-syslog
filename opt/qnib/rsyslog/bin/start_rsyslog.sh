#!/bin/bash

DEFAULT=true
if [ "X${FORWARD_TO_LOGSTASH}" == "Xtrue" ];then
   ln -sf /etc/rsyslog.d/logstash.conf.disabled /etc/rsyslog.d/logstash.conf  
   DEFAULT=false
fi
if [ "X${FORWARD_TO_KAFKA}" == "Xtrue" ];then
   ln -sf /etc/rsyslog.d/kafka.conf.disabled /etc/rsyslog.d/kafka.conf  
   DEFAULT=false
fi
if [ "X${FORWARD_TO_FILE}" == "Xtrue" ];then
   ln -sf /etc/rsyslog.d/file.conf.disabled /etc/rsyslog.d/file.conf  
   DEFAULT=false
fi
if [ ${DEFAULT} == "true" ];then
   ln -sf /etc/rsyslog.d/file.conf.disabled /etc/rsyslog.d/file.conf  
fi
/usr/sbin/rsyslogd -n
