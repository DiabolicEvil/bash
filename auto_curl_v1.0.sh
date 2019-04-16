###made by huyixin###
echo 该脚本会循环curl并生成curl.log
sleep 3
i=0;
while true;
do 
	i=$(($i+1));
	#check_results=$(curl -I --connect-timeout 10 -m 11 "http://1.132.105.245:8080/index.html")
	check_results=$(curl -I --connect-timeout 10 -m 11 "http://10.96.156.120:8080/fums/index.html")
	echo "$check_results"
	sleep 3
echo "########################################################################"
		if [[ $check_results =~  "HTTP/1.1 200" ]] 
		then 
			#生成时间变量
			current=`date "+%Y-%m-%d %H:%M:%S"`	
			echo "$current 200 OK"		
			echo "$current 200 OK" >> curl.log
		else 
			#生成时间变量
			current=`date "+%Y-%m-%d %H:%M:%S"`
			echo $current" ERROR curl: (28) Connection timed out after 10010 milliseconds"
			echo $current" ERROR curl: (28) Connection timed out after 10010 milliseconds" >> curl.log
		fi
echo 循环次数:$i
echo "########################################################################"
sleep 1

done

#curl常用方法
#curl -v http://101.132.105.245:8080
#curl -# -Lv "http://101.132.105.245:8080/index.html" -x "101.132.105.245:8080" -o /tmp/1