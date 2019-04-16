echo "Input FUMS IP	[输入需要连接的FUMS的IP地址(例如10.10.10.10)]:::"
read fumsip
	   
sleep 2	

echo [开始修改rabbitmq.properties配置文件]
echo [默认admin/admin如需修改账号密码请取消请取消下方注释或手动修改]

#echo 输入rabbitmq账号:::
#read userne
#echo 输入rabbitmq账号为:::$userne
#echo ---------------------------------
#echo 输入rabbitmq密码:::
#read passwd
#echo 输入rabbitmq密码为:::$passwd
#sed -i "s/\(rabbitmq.username=\)\S\S*/\1$userne/" /opt/fonsview/NE/agent/rabbitmq.properties
#rabbitsed -i "s/\(rabbitmq.password=\)\S\S*/\1$passwd/" /opt/fonsview/NE/agent/rabbitmq.properties
		
sed -i "s/\(rabbitmq.host=\)\S\S*/\1$fumsip/" /opt/fonsview/NE/agent/rabbitmq.properties
cat /opt/fonsview/NE/agent/rabbitmq.properties|head -n 7 | tail -n +3
echo ---------------------------------
echo rabbitmq.properties文件已修改
echo ---------------------------------
		
sleep 2	
		
sh /opt/fonsview/NE/agent/nestart.sh
		
echo ---------------------------------
echo -e "\033[32mFinish[已完成切换管理FUMS]\033[0m"
echo ---------------------------------