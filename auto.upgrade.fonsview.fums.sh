###made by huyixin###
if [ -z "$readversion" ]; then
           
	echo ---------------------------------     
	echo "List file[该目录下安装包为]:::"
	ls Fonsview.FUMS*.tar.gz
	echo ---------------------------------
	echo "已安装版本:::"
	sh /opt/fonsview/NE/fums/bin/version.sh
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

	if [ -e "Fonsview.FUMS_R3.2.1_$readversion.tar.gz" ];then
	tar -zxvf Fonsview.FUMS_R3.2.1_$readversion.tar.gz
	else
	echo ---------------------------------
	echo -e "\033[31mNo such file or directory[无此安装包 请重新输入]\033[0m"
	echo ---------------------------------
	exit 0 #sh auto.update.fonsview.fums.sh #输入错误版本号会重复多次循环可用exit 0
	fi

		sleep 5

	cd Fonsview.FUMS_R3.2.1_$vernum
	sh install.sh
	sleep 5
	cd /opt/fonsview/NE/fums/bin
	echo ---------------------------------
	ps -ef|grep fumstomcat
	echo ---------------------------------

id=`ps -ef | grep fumstomcat |sed '/grep/ d'| awk '{print $2 }'`

for pid in $id ; do
    echo --kill -9 $pid--
    if [ x"$pid" != x ] ; then
            kill -9 $pid >/dev/null 2>&1
    fi
done	

	./nestart.sh
	sleep 5
	echo ---------------------------------
	ps -ef|grep fumstomcat
	echo ---------------------------------
	sleep 20
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
fi











