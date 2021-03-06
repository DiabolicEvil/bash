#!/bin/sh
##auto_install_fonsview_round322_agent_v2.0
###made by huyixin###     
echo ---------------------------------     
echo "List file[该目录下安装包为]:::"
ls Fonsview.agent*.tar.gz
ls FV6300-AGENT*.tar.gz
echo ---------------------------------
echo "已安装版本:::"
sh /opt/fonsview/NE/fums/bin/version.sh
echo ---------------------------------
#带参数命令 例如./install.sh 7200
	vernum=$1
#确定是否带参数 带版本号直接安装对应版本 输入则提示输入版本号
if  [ ! -n "$vernum" ] ;then

#检查版本号是否为数字串
		i=1
        while(($i<100))
        do		
		echo -e "\033[31m该脚本会修改默认配置 仅用于首次安装\033[0m"
		echo --------------------------------- 
        echo "Input version info [输入需升级版本号(文件名末尾四位数字)]:::"
	    read vernum
            sleep 1
                ############
                expr $vernum "+" 10 &> /dev/null
                if [ $? -eq 0 ];then
						echo ---------------------------------
						echo "YOU INPUT VERSION INFO (版本号)::: $vernum"
						echo ---------------------------------

						
							sleep 2

							if [ -e "FV6300-FUMS-V3.2.2-$vernum-GEN.tar.gz" ];then
							tar -zxvf FV6300-FUMS-V3.2.2-$vernum-GEN.tar.gz
							else
							echo -e "\033[31mNo such file or directory[无此安装包 请重新执行该脚本]\033[0m"
							echo ---------------------------------
							exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0	
							fi
		
							sleep 3

							echo ---------------------------------
							#验证是否存在旧版本 如有旧版则移动目录
							if [ -e "/opt/fonsview/NE/fums" ];then
							#生成时间后缀
							current=`date "+%Y%m%d%H%M%S"` 
							echo 当前时间:::
							echo $current  
							mv -f /opt/fonsview/NE/fums /opt/fonsview/NE/fums_bak_$current
							echo -e "\033[32mFinish[旧版本已移动至/opt/fonsview/NE/fums_bak_$current 现在开始全新安装]\033[0m"	
							ls -l -h /opt/fonsview/NE/
							echo ---------------------------------	
							sleep 8
							else
							echo -e "\033[32mFinish[无旧版本 现在开始全新安装]\033[0m"								
							echo ---------------------------------	
							sleep 8
							fi
							
							cd FV6300-FUMS-V3.2.2-$vernum-GEN
							chmod +x *.sh
							sh install.sh
							cd /opt/fonsview/NE/agent
							# 判断是否有fumstomcat进程，有的话kill -9
							id=`ps -ef | grep fumstomcat |sed '/grep/ d'| awk '{print $2 }'`
							for pid in $id ; do
								echo --kill -9 $pid--
								if [ x"$pid" != x ] ; then
								kill -9 $pid >/dev/null 2>&1
							fi
							done		
							
							sleep 3
							
							echo ---------------------------------
								IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | grep -v '192.168'| awk '{ print $2}'` ;
								echo 本机IP为:::
								echo $IP
							echo 如获取本机IP不正确请手动修改对应配置文件		
							echo ---------------------------------
							
							echo [开始修改datasource.properties配置文件 首次安装才会修改数据库IP为本机IP]
							echo ---------------------------------							
							sleep 2
							cd /opt/fonsview/NE/fums/etc
							#cp datasource.properties.templ datasource.properties
							eval sed -i 's/localhost/"$IP"/' datasource.properties
							sed -i "s/\(jdbc.password=\)\S\S*/\1Hello123+/" datasource.properties 
							echo [默认修改为root/Hello123+ 需要自定义修改请取消下方注释并手动输入]
							#echo 输入本机数据库账号:::
							#read sqluser
							#echo 输入数据库账号为:::$sqluser
							#sed -i "s/\(jdbc.user=\)\S\S*/\1$sqluser/" datasource.properties
							#echo ---------------------------------
							#echo 输入本机数据库密码:::
							#read sqlpass
							#echo 输入数据库密码为:::$sqlpass
							#sed -i "s/\(jdbc.password=\)\S\S*/\1$sqlpass/" datasource.properties
							echo ---------------------------------
							sleep 5
							cat /opt/fonsview/NE/fums/etc/datasource.properties|head -n 6 | tail -n +3
							echo ---------------------------------
							
							echo [开始修改rabbitmq.properties配置文件]
							echo [默认admin/admin如需修改账号密码请取消请取消下方注释或手动修改]
							#echo 输入rabbitmq账号:::
							#read userne
							#echo 输入rabbitmq账号为:::$userne
							#echo ---------------------------------
							#echo 输入rabbitmq密码:::
							#read passwd
							#echo 输入rabbitmq密码为:::$passwd
							#sed -i "s/\(rabbitmq.username=\)\S\S*/\1$userne/" rabbitmq.properties
							#rabbitsed -i "s/\(rabbitmq.password=\)\S\S*/\1$passwd/" rabbitmq.properties
							echo ---------------------------------	
							sleep 5
							sed -i "s/\(rabbitmq.host=\)\S\S*/\1$IP/" rabbitmq.properties
							cat /opt/fonsview/NE/fums/etc/rabbitmq.properties|head -n 9 | tail -n +3
							
							echo ---------------------------------
							echo [开始修改fums-config.properties配置文件]
							echo ---------------------------------	
							sleep 5
							sed -i "s/\(FUMS_IP=\)\S\S*/\1$IP/" fums-config.properties
							cat /opt/fonsview/NE/fums/etc/fums-config.properties|head -n 8 | tail -n +8
							echo ---------------------------------
							echo [fums-config.properties中只修改了FUMS_IP 如需修改其他请取消和自定义下方注释并手动输入]
							echo 附加修改项:::
							echo

							#echo 输入LCM_IP:::
							#read lcm
							#echo 输入LCM_IP为:::$lcm
							#sed -i "s/\(LCM_IP=\)\S\S*/\1$lcm/" fums-config.properties
							#echo

							#echo 输入FCRS_WEB_IP:::
							#read fcrs
							#echo 输入FCRS_WEB_IP:::$fcrs
							#sed -i "s/\(FCRS_WEB_IP=\)\S\S*/\1$fcrs/" fums-config.properties
							#echo

							#echo 输入DAAS_FOREIGN_IP:::
							#read daas1
							#echo 输入DAAS_FOREIGN_IP为:::$daas1
							#sed -i "s/\(DAAS_FOREIGN_IP=\)\S\S*/\1$daas1/" fums-config.properties
							#echo

							#echo 输入DAAS_WEB_IP:::
							#read daas2
							#echo 输入LCM_IP为:::$daas2
							#sed -i "s/\(DAAS_WEB_IP=\)\S\S*/\1$daas2/" fums-config.properties
							#echo

							#echo 输入DAAS_WEB_PORT:::
							#read daas3
							#echo 输入DAAS_WEB_PORT为:::$daas3
							#sed -i "s/\(DAAS_WEB_PORT=\)\S\S*/\1$daas3/" fums-config.properties
							#echo

							#echo 输入DAAS_CONFIG_IP:::
							#read daas4
							#echo 输入DAAS_CONFIG_IP为:::$daas4
							#sed -i "s/\(DAAS_CONFIG_IP=\)\S\S*/\1$daas4/" fums-config.properties
							#echo

							echo ---------------------------------
							echo -e "\033[32mFinish[FUMS配置文件已修改]\033[0m"	
							echo ---------------------------------

							cd /opt/fonsview/NE/fums/bin
							sh nestart.sh
							sleep 5
							echo ---------------------------------
							ps -ef|grep fumstomcat
							echo ---------------------------------
							sleep 35
							ls /opt/fonsview/NE/fums/install_first/
							echo ---------------------------------
							echo "版本号:::"
							sh version.sh
							echo ---------------------------------
							sleep 20
							echo "进程状态:::"
							sh status.sh
							echo ---------------------------------
							
							echo 本机IP为:::
							ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}'  
							IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
							echo 请访问:::
							echo http://"$IP":8080/fums
							echo 如果进程状态为start状态时页面显示不全或不显示 请清空浏览器缓存后重试
							echo 默认账户名:::
							echo sysadmin
							echo 默认密码:::
							echo 111111
							echo 未覆盖properties文件 如有变动请核对properties.templ文件手动更改
							echo ---------------------------------
							echo -e "\033[32mFinish[已完成升级]\033[0m"
							echo ---------------------------------
							exit 0

                        break
                else
                        echo -e "\033[31mYOU INPUT VERSION INFO [版本号] NOT A number[请输入数字]!!!\033[0m"
                        let "i++"
                fi
        done

	
else
    echo "YOU INPUT VERSION INFO (版本号)::: $vernum"
	echo ---------------------------------
		if [ -e "FV6300-AGENT-V3.2.2-$vernum-GEN.tar.gz" ];then
		ls -lh FV6300-AGENT-V3.2.2-$vernum-GEN.tar.gz
		echo ---------------------------------
		echo "YOU INPUT FUMS IP (FUMS IP)::: $fumsip"
		else
		echo -e "\033[31mNo such file or directory[无此安装包 请重新执行该脚本]\033[0m"
		echo ---------------------------------
		exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0
		fi
		
	echo ---------------------------------
	
	sleep 3
	
	echo 准备安装该版本（ctrl+c可终止）......
	echo 倒计时5
	sleep 2
	echo 倒计时4
	sleep 2
	echo 倒计时3
	sleep 2
	echo 倒计时2
	sleep 2
	echo 倒计时1
	sleep 2
	if [ -e "FV6300-FUMS-V3.2.2-$vernum-GEN.tar.gz" ];then
	tar -zxvf FV6300-FUMS-V3.2.2-$vernum-GEN.tar.gz
	else
	echo -e "\033[31mNo such file or directory[无此安装包 请重新执行该脚本]\033[0m"
	echo ---------------------------------
	exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0	
	fi
		
	sleep 3

	echo ---------------------------------
	#验证是否存在旧版本 如有旧版则移动目录
	if [ -e "/opt/fonsview/NE/fums" ];then
	#生成时间后缀
	current=`date "+%Y%m%d%H%M%S"` 
	echo 当前时间:::
	echo $current  
	mv -f /opt/fonsview/NE/fums /opt/fonsview/NE/fums_bak_$current
	echo -e "\033[32mFinish[旧版本已移动至/opt/fonsview/NE/fums_bak_$current 现在开始全新安装]\033[0m"	
	ls -l -h /opt/fonsview/NE/
	echo ---------------------------------	
	sleep 8
	else
	echo -e "\033[32mFinish[无旧版本 现在开始全新安装]\033[0m"								
	echo ---------------------------------	
	sleep 8
	fi
					
	cd FV6300-FUMS-V3.2.2-$vernum-GEN
	chmod +x *.sh
	sh install.sh
	cd /opt/fonsview/NE/agent
	# 判断是否有fumstomcat进程，有的话kill -9
	id=`ps -ef | grep fumstomcat |sed '/grep/ d'| awk '{print $2 }'`
	for pid in $id ; do
	echo --kill -9 $pid--
	if [ x"$pid" != x ] ; then
	kill -9 $pid >/dev/null 2>&1
	fi
	done		
							
	sleep 3
							
	echo ---------------------------------
		IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | grep -v '192.168'| awk '{ print $2}'` ;
		echo 本机IP为:::
		echo $IP
	echo 如获取本机IP不正确请手动修改对应配置文件		
	echo ---------------------------------
							
	echo [开始修改datasource.properties配置文件 首次安装才会修改数据库IP为本机IP]
	echo ---------------------------------							
	sleep 2
	cd /opt/fonsview/NE/fums/etc
	#cp datasource.properties.templ datasource.properties
	eval sed -i 's/localhost/"$IP"/' datasource.properties
	sed -i "s/\(jdbc.password=\)\S\S*/\1Hello123+/" datasource.properties 
	echo [默认修改为root/Hello123+ 需要自定义修改请取消下方注释并手动输入]
	#echo 输入本机数据库账号:::
	#read sqluser
	#echo 输入数据库账号为:::$sqluser
	#sed -i "s/\(jdbc.user=\)\S\S*/\1$sqluser/" datasource.properties
	#echo ---------------------------------
	#echo 输入本机数据库密码:::
	#read sqlpass
	#echo 输入数据库密码为:::$sqlpass
	#sed -i "s/\(jdbc.password=\)\S\S*/\1$sqlpass/" datasource.properties
	echo ---------------------------------
	sleep 5
	cat /opt/fonsview/NE/fums/etc/datasource.properties|head -n 6 | tail -n +3
	echo ---------------------------------
	
	echo [开始修改rabbitmq.properties配置文件]
	echo [默认admin/admin如需修改账号密码请取消请取消下方注释或手动修改]
	#echo 输入rabbitmq账号:::
	#read userne
	#echo 输入rabbitmq账号为:::$userne
	#echo ---------------------------------
	#echo 输入rabbitmq密码:::
	#read passwd
	#echo 输入rabbitmq密码为:::$passwd
	#sed -i "s/\(rabbitmq.username=\)\S\S*/\1$userne/" rabbitmq.properties
	#rabbitsed -i "s/\(rabbitmq.password=\)\S\S*/\1$passwd/" rabbitmq.properties
	echo ---------------------------------	
	sleep 5
	sed -i "s/\(rabbitmq.host=\)\S\S*/\1$IP/" rabbitmq.properties
	cat /opt/fonsview/NE/fums/etc/rabbitmq.properties|head -n 9 | tail -n +3
							
	echo ---------------------------------
	echo [开始修改fums-config.properties配置文件]
	echo ---------------------------------	
	sleep 5
	sed -i "s/\(FUMS_IP=\)\S\S*/\1$IP/" fums-config.properties
	cat /opt/fonsview/NE/fums/etc/fums-config.properties|head -n 8 | tail -n +8
	echo ---------------------------------
	echo [fums-config.properties中只修改了FUMS_IP 如需修改其他请取消和自定义下方注释并手动输入]
	echo 附加修改项:::
	echo

	#echo 输入LCM_IP:::
	#read lcm
	#echo 输入LCM_IP为:::$lcm
	#sed -i "s/\(LCM_IP=\)\S\S*/\1$lcm/" fums-config.properties
	#echo

	#echo 输入FCRS_WEB_IP:::
	#read fcrs
	#echo 输入FCRS_WEB_IP:::$fcrs
	#sed -i "s/\(FCRS_WEB_IP=\)\S\S*/\1$fcrs/" fums-config.properties
	#echo

	#echo 输入DAAS_FOREIGN_IP:::
	#read daas1
	#echo 输入DAAS_FOREIGN_IP为:::$daas1
	#sed -i "s/\(DAAS_FOREIGN_IP=\)\S\S*/\1$daas1/" fums-config.properties
	#echo

	#echo 输入DAAS_WEB_IP:::
	#read daas2
	#echo 输入LCM_IP为:::$daas2
	#sed -i "s/\(DAAS_WEB_IP=\)\S\S*/\1$daas2/" fums-config.properties
	#echo

	#echo 输入DAAS_WEB_PORT:::
	#read daas3
	#echo 输入DAAS_WEB_PORT为:::$daas3
	#sed -i "s/\(DAAS_WEB_PORT=\)\S\S*/\1$daas3/" fums-config.properties
	#echo

	#echo 输入DAAS_CONFIG_IP:::
	#read daas4
	#echo 输入DAAS_CONFIG_IP为:::$daas4
	#sed -i "s/\(DAAS_CONFIG_IP=\)\S\S*/\1$daas4/" fums-config.properties
	#echo

	echo ---------------------------------
	echo -e "\033[32mFinish[FUMS配置文件已修改]\033[0m"	
	echo ---------------------------------

	cd /opt/fonsview/NE/fums/bin
	sh nestart.sh
	sleep 5
	echo ---------------------------------
	ps -ef|grep fumstomcat
	echo ---------------------------------
	sleep 35
	ls /opt/fonsview/NE/fums/install_first/
	echo ---------------------------------
	echo "版本号:::"
	sh version.sh
	echo ---------------------------------
	sleep 20
	echo "进程状态:::"
	sh status.sh
	echo ---------------------------------
							
	echo 本机IP为:::
	ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}'  
	IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' |grep -v '192.168' | awk '{ print $2}'` ;
	echo 请访问:::
	echo http://"$IP":8080/fums
	echo 如果进程状态为start状态时页面显示不全或不显示 请清空浏览器缓存后重试
	echo 默认账户名:::
	echo sysadmin
	echo 默认密码:::
	echo 111111
	echo 未覆盖properties文件 如有变动请核对properties.templ文件手动更改
	echo ---------------------------------
	echo -e "\033[32mFinish[已完成升级]\033[0m"
	echo ---------------------------------
	exit 0
fi


		











