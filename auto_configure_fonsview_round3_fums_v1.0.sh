###made by huyixin###
echo ---------------------------------
        IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
        echo 本机IP为:::
        echo $IP

echo ---------------------------------
echo [开始修改datasource.properties配置文件 首次安装才会修改数据库IP为本机IP]
echo ---------------------------------	
sleep 2

cd /opt/fonsview/NE/fums/etc
#cp datasource.properties.templ datasource.properties
eval sed -i 's/localhost/"$IP"/' datasource.properties
sed -i "s/\(jdbc.password=\)\S\S*/\1Hello123+/" datasource.properties 

echo [默认修改为root/Hello123+ 需要自定义修改请取消下方注释]
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
echo [fums-config.properties中只修改了FUMS_IP 如需修改其他请取消和自定义下方注释]
echo 附加修改项:::
echo

echo 输入LCM_IP:::
read lcm
echo 输入LCM_IP为:::$lcm
sed -i "s/\(LCM_IP=\)\S\S*/\1$lcm/" fums-config.properties
echo

echo 输入FCRS_WEB_IP:::
read fcrs
echo 输入FCRS_WEB_IP:::$fcrs
sed -i "s/\(FCRS_WEB_IP=\)\S\S*/\1$fcrs/" fums-config.properties
echo

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
