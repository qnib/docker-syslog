#!/bin/bash

if [ "X${FORWARD_TO_LOGSTASH}" == "Xtrue" ];then
   ln -sf /etc/syslog-ng/conf.d/logstash.conf.disabled /etc/syslog-ng/conf.d/logstash.conf  
fi
if [ "X${FORWARD_TO_KAFKA}" == "Xtrue" ];then
   ln -sf /etc/syslog-ng/conf.d/kafka.conf.disabled /etc/syslog-ng/conf.d/kafka.conf  
fi

/usr/sbin/syslog-ng --foreground
