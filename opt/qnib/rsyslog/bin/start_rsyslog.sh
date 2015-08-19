#!/bin/bash

function stop_rsyslog {
     PID=$(cat /var/run/rsyslogd.pid)
     echo "Stopping rsyslog[${PID}]"
     kill -9 ${PID}
     if [ -f /var/run/rsyslogd.pid ];then
         echo "GarbageCollect PID file"
         rm -f /var/run/rsyslogd.pid
     fi
}
trap stop_rsyslog HUP INT TERM EXIT

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
   if [ ! -f /etc/rsyslog.d/file.conf ];then
       ln -sf /etc/rsyslog.d/file.conf.disabled /etc/rsyslog.d/file.conf  
   fi
   DEFAULT=false
fi
if [ ${DEFAULT} == "true" ];then
   if [ ! -f /etc/rsyslog.d/file.conf ];then
       ln -sf /etc/rsyslog.d/file.conf.disabled /etc/rsyslog.d/file.conf  
   fi
fi
/usr/sbin/rsyslogd 
while true
do
  sleep 1
done
