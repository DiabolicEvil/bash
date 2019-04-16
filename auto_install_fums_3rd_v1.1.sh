###made by huyixin###
echo 该脚本会安装jre、mysql、rabbitmq、tomcat，该脚本仅在全新安装的CentOS_7.1_OEM_5测试通过
echo 注意：该脚本会卸载Mysql重新安装，如不需要手动注释
echo 需要先scp -r admin@10.96.155.155:/volume1/public/chinamobile/3rd/ /root/ 


sleep 1
echo 5
sleep 1
echo 4
sleep 1
echo 3
sleep 1
echo 2
sleep 1
echo 1
sleep 1
echo START
sleep 2

echo 系统解固[安装好后可再次加固]
sleep 2
chattr -i /etc/passwd
chattr -i /etc/shadow
chattr -i /etc/group
chattr -i /etc/gshadow
chattr -R -i /bin /boot /lib /sbin
chattr -R -i /usr/bin /usr/include /usr/lib /usr/sbin
chattr -a /var/log/messages /var/log/secure /var/log/maillog

echo 安装jre1.8.44
sleep 2
tar -zxvf Fonsview.3rd_party_jre_1.8.44.tar.gz
cd Fonsview.3rd_party_jre_1.8.44
sh install.sh
source /etc/profile
java -version
sleep 5

echo 安装mysql
sleep 2
cd ..
tar -zxvf Mysql5.7.23.tar.gz

cp Mysql5.7.23sh/install.sh Mysql5.7.23/
cp Mysql5.7.23sh/uninstall.sh Mysql5.7.23/

cd Mysql5.7.23
chmod +x *.sh
sh uninstall.sh
sh install.sh
service mysqld start

echo 提取mysql临时密码
sleep 2
grep -an "temporary password" /var/log/mysqld.log
temppass=$(awk '{if($0~"temporary password") print $11}' /var/log/mysqld.log)
#cat /var/log/mysqld.log | grep password | head -1 | rev  | cut -d ' ' -f 1 | rev
echo
echo $temppass

echo 创建数据库
sleep 2
echo [默认密码为root/Hello123+ 创建fumsdb 需要自定义请手动修改下方内容]
mysql --connect-expired-password -uroot -p$temppass -e "ALTER USER USER() IDENTIFIED BY 'Hello123+';"
newpass=Hello123+
#mysql -uroot -p$newpass -e "ALTER USER USER() IDENTIFIED BY 'Hello123+';"
mysql -uroot -p$newpass -e "flush privileges;"
mysql -uroot -p$newpass -e "create database fumsdb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -uroot -p$newpass -e "grant select,insert,update,delete on *.* to fums@'%' identified by 'Hello123+';"
mysql -uroot -p$newpass -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY  'Hello123+'  WITH 	GRANT OPTION;"
mysql -uroot -p$newpass -e "FLUSH PRIVILEGES;"
mysql -uroot -p$newpass -e "show databases;"
chkconfig --level 2345 mysqld on

#echo mysql第10行添加 修复5716版本重启后无法启动（倒序）
#sleep 2
#sed -i 'N;10afi' /etc/rc.d/init.d/mysqld
#sed -i 'N;10achown -R mysql:mysql /var/run/mysqld/' /etc/rc.d/init.d/mysqld
#sed -i 'N;10amkdir -p /var/run/mysqld/' /etc/rc.d/init.d/mysqld
#sed -i 'N;10aif [ ! -d "/var/run/mysqld/" ];then' /etc/rc.d/init.d/mysqld

echo 安装tomcat-fums
sleep 2
cd ..
tar -zxvf Fonsview.tomcat_FUMS_8.5.34_4172.tar.gz
cd Fonsview.tomcat_8.5.34_4172
sh install.sh

echo 安装rabbitmq组件erl
sleep 2
cd ..
tar -zxvf otp_src_17.1.tar.gz
cd otp_src_17.1
sh configure
make && make install
erl -version
sleep 5

echo 安装rabbitmq
sleep 2
cd ..
tar -zxvf Fonsview.3rd_party_rabbitmq-3.3.4.tar.gz  
cd Fonsview.3rd_party_rabbitmq-3.3.4
sh install.sh
cp /opt/fonsview/3RD/rabbitmq/.erlang.cookie /root/
service rabbitmq start
/opt/fonsview/3RD/rabbitmq/sbin/rabbitmqctl add_user admin admin
/opt/fonsview/3RD/rabbitmq/sbin/rabbitmqctl set_user_tags admin administrator
/opt/fonsview/3RD/rabbitmq/sbin/rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
/opt/fonsview/3RD/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_management
service rabbitmq restart
IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
curl -v http://$IP:15672

echo 安装nginx
sleep 2
cd ..
tar -zxvf Fonsview.nginx_1.8.1_24262.tar.gz
cd Fonsview.nginx_1.8.1_24261
sh install.sh
eval sed -i 's/172.16.17.132/"$IP"/' /opt/fonsview/3RD/nginx/conf/nginx.conf
service nginx stop
service nginx start

sleep 5
echo ---------------------------------
echo 显示所有进程
echo ---------------------------------
ps -ef|grep mysqld
sleep 2
echo ---------------------------------
ps -ef|grep tomcat
sleep 2
echo ---------------------------------
ps -ef|grep rabbitmq
sleep 2
echo ---------------------------------
ps -ef|grep nginx
sleep 2
echo ---------------------------------
echo -e "\033[32mFinish[3RD环境已全部安装]\033[0m"	
echo ---------------------------------

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 