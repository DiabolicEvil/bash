###made by huyixin###
echo ---------------------------------
echo 杀掉flume进程
sleep 3

id=`ps -ef | grep flume |sed '/grep/ d'| awk '{print $2 }'`
for pid in $id ; do
    echo --kill -9 $pid--
    if [ x"$pid" != x ] ; then
            kill -9 $pid >/dev/null 2>&1
    fi
done

sleep 3
echo ---------------------------------
echo 显示flume进程是否被正确结束	
sleep 3
ps -ef |grep flume


sleep 3
echo ---------------------------------
echo 旧版本文件备份加时间后缀
sleep 3
current=`date "+%Y%m%d%H%M%S"` 
echo 当前时间:::
echo $current  
mv /opt/fonsview/3RD/flume /opt/fonsview/3RD/flume_$current 

sleep 3
echo ---------------------------------
echo 安装flume
sleep 3
cd Fonsview.flume_*
sh install.sh

sleep 3
echo ---------------------------------
echo 安装flume
sleep 3
cd ..
cd Fonsview.flume_patch*
cd install
sh install.sh -f

sleep 3
echo ---------------------------------
echo 启动flume
sleep 3
cd /opt/fonsview/3RD/flume/bin
sh start.sh

sleep 3
	echo ---------------------------------
	echo -e "\033[32mFinish[已成功安装新版本flume_CSD/CSX客户端]\033[0m"
	echo ---------------------------------











