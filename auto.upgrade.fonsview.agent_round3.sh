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
	

		########### 检查版本号是否为数字串
	 i=1
        while(($i<100))
        do
		
            echo "Input version info [输入版本号(文件名末尾四位数字)]:::"
	   read vernum
            sleep 1
                ############
                expr $vernum "+" 10 &> /dev/null
                if [ $? -eq 0 ];then
                        echo "YOU INPUT VERSION INFO (版本号)::: $vernum"
                readversion=$vernum;
		sleep 2

	if [ -e "FV6300-AGENT-V3.2.1-$readversion-GEN.tar.gz" ];then
	tar -zxvf FV6300-AGENT-V3.2.1-$readversion-GEN.tar.gz
	else
	echo ---------------------------------
	echo -e "\033[31mNo such file or directory[无此安装包 请重新输入]\033[0m"
	echo ---------------------------------
	exit 0 #sh auto.update.fonsview.agent.sh #输入错误版本号会重复多次循环可用exit 0	
	fi
		
		sleep 5


	cd Fonsview.agent_R3.2.1_$vernum
	sh install.sh
	cd /opt/fonsview/NE/agent
	echo ---------------------------------
	ps -ef|grep agent.jar
	echo ---------------------------------
	./nestart.sh
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
fi











