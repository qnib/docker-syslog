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

function check_heka {
    cnt_srv=$(curl -s localhost:8500/v1/catalog/service/heka|grep -c "\"Node\":\"$(hostname)\"")
    if [ ${cnt_srv} -ne 1 ];then
        echo "[start_rsyslog] No running 'hdfs service yet, sleep 5 sec'"
        sleep 5
        check_heka
    fi
}

trap stop_rsyslog HUP INT TERM EXIT

DEFAULT=true
if [ "X${FORWARD_TO_KAFKA}" == "Xtrue" ];then
   ln -sf /etc/rsyslog.d/kafka.conf.disabled /etc/rsyslog.d/kafka.conf  
   DEFAULT=false
fi
if [ "X${FORWARD_TO_HEKA}" == "Xtrue" ];then
   check_heka
   ln -sf /etc/rsyslog.d/heka.conf.disabled /etc/rsyslog.d/heka.conf  
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
