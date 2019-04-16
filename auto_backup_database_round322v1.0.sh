###made by huyixin###
echo ---------------------------------
echo 该脚本会将fumsdb备份至/root/backup_database后添加版本号和时间后缀并保存最近90天备份文件
sleep 2
echo 定期自动备份配置请查看本脚本最后部分
sleep 2

#检查/root/backup_database目录是否存在 如不存在则创建
mkdir -p /root/backup_database

echo ---------------------------------
#生成时间后缀
current=`date "+%Y%m%d%H%M%S"` 
echo 当前时间:::
echo $current  
echo ---------------------------------
echo 当前fums版本:::

#查看完整版本号
#sh /opt/fonsview/NE/fums/bin/version.sh

#截取版本号
cd /opt/fonsview/NE/fums/deploy/src/modules/about
version=`cat about.html|grep 'FV6300'|cut -d '>' -f 4 | cut -d '<' -f 1 | head -1`
ver1=${version:0-8}
ver2=${ver1%%-*}
echo $ver2

#拼接字符串变量
ver3=$ver2"_"$current

echo ---------------------------------
echo 请输入数据库密码:::
echo 默认自动输入密码Hello123+ 如有误请替换下方内容

#自动输入 替换-p后面为数据库密码
mysqldump -u root -pHello123+ fumsdb>/root/backup_database/fumsdb_$ver3.sql

#手动输入
#mysqldump -u root -p fumsdb>/root/backup_database/fumsdb_$ver3.sql

echo ---------------------------------

echo 备份文件已生成:::
ls -l -h /root/backup_database/fumsdb_$ver3.sql
echo ---------------------------------

sleep 2
echo 开始清除backup_database目录下90天之前备份文件（不显示文件名则无90天之前备份文件）
echo 可自行修改该脚本-mtime +90参数来修改天数
sleep 2
find /root/backup_database/* -type f -mtime +90 -exec ls -l {} \;
echo 准备清除文件（ctrl+c可终止）......
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
find /root/backup_database/* -type f -mtime +90 -exec rm {} \;
echo 已清除90天之前备份文件



echo ---------------------------------
echo -e "\033[32mFinish[fumsdb数据库已备份]\033[0m"	
echo ---------------------------------


#定期自动备份配置
#输入以下命令修改系统crontab
# crontab -e
#例子如下
#每天早上6点执行该脚本则添加如下一行保存
#0 6 * * * /root/auto_backup_database_round322v1.0.sh
#每个月的第一天 13:10分运行则添加如下一行保存
#10 13 1 * * /root/auto_backup_database_round322v1.0.sh
#显示所有crontab
#crontab -l