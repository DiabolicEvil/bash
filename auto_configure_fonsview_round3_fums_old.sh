###made by huyixin###
echo ---------------------------------
        IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
        echo 本机IP为:::
        echo $IP

echo ---------------------------------
echo [开始修改datasource.properties配置文件]
echo ---------------------------------	
sleep 5

cp datasource.properties.templ datasource.properties
eval sed -i 's/localhost/"$IP"/' datasource.properties
echo 输入本机数据库账号:::
read sqluser
echo 输入数据库账号为:::$sqluser
sed -i "s/\(jdbc.user=\)\S\S*/\1$sqluser/" datasource.properties
echo ---------------------------------
echo 输入本机数据库密码:::
read sqlpass
echo 输入数据库密码为:::$sqlpass
sed -i "s/\(jdbc.password=\)\S\S*/\1$sqlpass/" datasource.properties
mv datasource.properties /opt/fonsview/NE/fums/etc/
echo ---------------------------------

sleep 5
cat /opt/fonsview/NE/fums/etc/datasource.properties|head -n 6 | tail -n +3
echo ---------------------------------

echo [开始修改rabbitmq.properties配置文件]
echo ---------------------------------	
sleep 5
cp rabbitmq.properties.templ rabbitmq.properties
sed -i "s/\(rabbitmq.host=\)\S\S*/\1$IP/" rabbitmq.properties
mv rabbitmq.properties /opt/fonsview/NE/fums/etc/
cat /opt/fonsview/NE/fums/etc/rabbitmq.properties|head -n 9 | tail -n +3

echo ---------------------------------
echo [开始修改fums-config.properties配置文件]
echo ---------------------------------	
sleep 5
cp fums-config.properties.templ fums-config.properties
sed -i "s/\(FUMS_IP=\)\S\S*/\1$IP/" fums-config.properties
mv fums-config.properties /opt/fonsview/NE/fums/etc/
cat /opt/fonsview/NE/fums/etc/fums-config.properties|head -n 8 | tail -n +8

echo ---------------------------------
echo -e "\033[32mFinish[FUMS配置文件已修改]\033[0m"	
echo ---------------------------------
