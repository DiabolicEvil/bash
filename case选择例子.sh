#!/bin/bash
# tomcat8 Startup script for agent
#
# chkconfig: 2345 85 15
# description: agent.jar
#
# processname: tomcat8
. /etc/rc.d/init.d/functions
TOMCAT_PATH=/opt/fonsview/3RD/fumstomcat
source /etc/profile

export LD_LIBRARY_PATH=.:${LD_LIBRARY_PATH}
cd $TOMCAT_PATH
case "$1" in
        start)
                 echo `ps -ef | grep  fumstomcat | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -  >/dev/null 2>&1`
                                  sleep 3
                                  echo "tomcat8 is stop"
                                  $TOMCAT_PATH/bin/catalina.sh start
        ;;
        stop)
                                id=`ps -ef | grep fumstomcat | grep -v grep | awk '{print $2}'`
                                for pid in $id ; do
                                echo --kill -9 $pid--
                                if [ x"$pid" != x ] ; then
                                        kill -9 $pid
                                fi
                done
        ;;
        restart)
                echo `ps -ef | grep  fumstomcat | grep -v grep | awk '{print $2}' | sed -e "s/^/kill -9 /g" | sh -  >/dev/null 2>&1`
                sleep 3
                echo "tomcat8 is stop"
                $TOMCAT_PATH/bin/catalina.sh start
        ;;
        6666)
                echo 66666666
        ;;		
        *)
                echo "Usage: tomcat8 {start|stop|restart|6666}"
        ;;
esac
exit 0