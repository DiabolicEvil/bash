###made by huyixin###
if [ -z "$readversion" ]; then       
	echo ---------------------------------     
	echo "List file[该目录下安装包为]:::"
	ls Fonsview.agent*.tar.gz
	ls FV6300-AGENT*.tar.gz
	echo ---------------------------------
	echo "已安装版本:::"
	cat /opt/fonsview/NE/agent/version.properties
	echo
	echo ---------------------------------
	echo 该脚本仅用于首次安装 升级请使用upgrade脚本
	echo ---------------------------------

		########### 检查版本号是否为数字串
	 i=1
        while(($i<100))
        do
		
            echo "Input version info [输入需安装版本号(文件名末尾四位数字)]:::"
	   read vernum
			echo "Input FUMS IP	[输入需要连接的FUMS的IP地址(例如10.10.10.10)]:::"
	   read fumsip
            sleep 1
                ############
                expr $vernum "+" 10 &> /dev/null
                if [ $? -eq 0 ];then
						echo ---------------------------------
                        echo "YOU INPUT VERSION INFO (版本号)::: $vernum"
						echo "YOU INPUT FUMS IP (FUMS IP)::: $fumsip"
						echo ---------------------------------
                readversion=$vernum;
		sleep 2

	if [ -e "FV6300-AGENT-V3.2.2-$readversion-GEN.tar.gz" ];then
	tar -zxvf FV6300-AGENT-V3.2.2-$readversion-GEN.tar.gz
	else
	echo ---------------------------------
	echo -e "\033[31mNo such file or directory[无此安装包 请重新输入]\033[0m"
	echo ---------------------------------
	exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0	
	fi
		
	sleep 5


	cd Fonsview.agent_R3.2.2_$vernum
	chmod +x *.sh
	sh install.sh
	cd /opt/fonsview/NE/agent
	
# 判断是否有agent进程，有的话kill -9
id=`ps -ef | grep agent.jar |sed '/grep/ d'| awk '{print $2 }'`

for pid in $id ; do
    echo --kill -9 $pid--
    if [ x"$pid" != x ] ; then
            kill -9 $pid >/dev/null 2>&1
    fi
done	
		
	echo ---------------------------------
	ps -ef|grep agent.jar
	echo ---------------------------------
        IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
        echo 本机IP为:::
        echo $IP
	echo ---------------------------------	
	sed -i "s/\(AGENT_IP=\)\S\S*/\1$IP/" SystemConfig.properties
	cat /opt/fonsview/NE/agent/SystemConfig.properties|head -n 9 | tail -n +3
	echo
	echo ---------------------------------
	echo SystemConfig.properties文件已修改
	echo ---------------------------------
	sleep 5	
	sed -i "s/\(rabbitmq.host=\)\S\S*/\1$fumsip/" rabbitmq.properties
	cat /opt/fonsview/NE/agent/rabbitmq.properties|head -n 7 | tail -n +3
	echo ---------------------------------
	echo rabbitmq.properties文件已修改
    	echo ---------------------------------
	sleep 5
	./nestart.sh
	sleep 5
	echo ---------------------------------
	ps -ef|grep agent.jar
	echo ---------------------------------
	echo "版本号:::"
	cat version.properties
	echo
	echo ---------------------------------
	echo -e "\033[32mFinish[已完成首次安装AGENT]\033[0m"
	echo ---------------------------------
	exit 0




                        break
                else
                        echo -e "\033[31mYOU INPUT VERSION INFO [版本号] NOT A number[请输入数字]!!!\033[0m"
                        let "i++"
                fi
        done
fi











