#!/bin/sh
##auto_upgrade_fonsview_round322_agent_v2.0
###made by huyixin###     
echo ---------------------------------     
echo "List file[该目录下安装包为]:::"
ls Fonsview.agent*.tar.gz
ls FV6300-AGENT*.tar.gz
echo ---------------------------------
echo "已安装版本:::"
cat /opt/fonsview/NE/agent/version.properties
echo
echo ---------------------------------
#带参数命令 例如./install.sh 7200
	vernum=$1
#确定是否带参数 带版本号直接安装对应版本 输入则提示输入版本号
if  [ ! -n "$vernum" ] ;then

#检查版本号是否为数字串
		i=1
        while(($i<100))
        do		
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

							if [ -e "FV6300-AGENT-V3.2.2-$vernum-GEN.tar.gz" ];then
							tar -zxvf FV6300-AGENT-V3.2.2-$vernum-GEN.tar.gz
							else
							echo -e "\033[31mNo such file or directory[无此安装包 请重新执行该脚本]\033[0m"
							echo ---------------------------------
							exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0	
							fi
		
							sleep 5

							cd FV6300-AGENT-V3.2.2-$vernum-GEN
							chmod +x *.sh
							sh install.sh
							cd /opt/fonsview/NE/agent
							echo ---------------------------------
							ps -ef|grep agent.jar
							echo ---------------------------------
							chmod +x *.sh
							sh nestart.sh
							
							sleep 5
							
							echo ---------------------------------
							ps -ef|grep agent.jar
							echo ---------------------------------
							echo "版本号:::"
							cat version.properties
							echo
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
	tar -zxvf FV6300-AGENT-V3.2.2-$vernum-GEN.tar.gz
	cd FV6300-AGENT-V3.2.2-$vernum-GEN
	chmod +x *.sh
	sh install.sh
	cd /opt/fonsview/NE/agent
	echo ---------------------------------
	ps -ef|grep agent.jar
	echo ---------------------------------
	chmod +x *.sh
	sh nestart.sh
							
	sleep 5
							
	echo ---------------------------------
	ps -ef|grep agent.jar
	echo ---------------------------------
	echo "版本号:::"
	cat version.properties
	echo
	echo ---------------------------------
	echo -e "\033[32mFinish[已完成升级]\033[0m"
	echo ---------------------------------
	exit 0
fi


		











