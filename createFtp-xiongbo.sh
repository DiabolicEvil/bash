#!/bin/sh
# (echo 'ftppassword';sleep 1;echo "ftppassword")| passwd  ftpuser
# [root@its ~]# (echo 'ftppassword';sleep 1;echo "ftppassword")| passwd  ftpuser
# Changing password for user ftpuser.
# New password: BAD PASSWORD: The password contains the user name in some form
# Retype new password: passwd: all authentication tokens updated successfully.
# shell 处理交互式命令的解决方案
#《[https://jingyan.baidu.com/article/9f63fb91dd158fc8410f0e79.html]》

# 1.创建ftp上传根目录#
# [root@CS4 fonsview]# 
mkdir -p /opt/fonsview/data/media

# 3.配置FTP服务器禁止匿名上传，修改配置文件，以及设置相关信息
# [root@CS4 fonsview]# vi /etc/vsftpd/vsftpd.conf
# anonymous_enable=NO  #禁止匿名登录
# 尾部添加
# seccomp_sandbox=NO
echo "export local_root=/opt/fonsview/data/media" >> /etc/vsftpd/vsftpd.conf
echo "export anon_root=/opt/fonsview/data/media" >> /etc/vsftpd/vsftpd.conf
echo "export chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf
echo "export allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf

# pam_service_name=vsftpd
# userlist_enable=YES
# tcp_wrappers=YES
# seccomp_sandbox=NO
# local_root=/opt/fonsview/data/media
# anon_root=/opt/fonsview/data/media
# chroot_local_user=YES
# allow_writeable_chroot=YES
# pasv_enable=NO
# 清空一个文件最优的方法 echo "" > fums.log

# 2.3.2修改上传目录属性
# 1.创建ftp用户ftpuser======并设置其密码为ftpuser
# [root@CS4 fonsview]# groupadd ftp
# ********解决7.1下  
# [root@tb-cms-epg fonsview]# groupadd ftp
chattr -i  /etc/gshadow
chattr -i  /etc/group
chattr -i  /etc/passwd
chattr -i  /etc/shadow 
groupadd ftp

useradd -G ftp -d /opt/fonsview/data/media -M ftpuser
(echo 'ftpuser';sleep 2;echo "ftpuser")| passwd  ftpuser

# 2.改变文件夹的属主和权限
chown -R ftpuser:ftpuser /opt/fonsview/data/media
chown -R ftpuser:ftpuser /opt/fonsview/data

# 3.改变父文件夹权限
chmod 755 /opt/fonsview
chmod -R 766 /opt/fonsview/data
# 4.改变目录权限
chmod -R 766 /opt/fonsview/data/media
	
#5.启动ftp服务
service vsftpd start
service vsftpd status
chkconfig --list  ##默认开机启动列表查询
chkconfig --level 2345 vsftpd on ##设置默认开机启动

# 6.测试FTP服务器
# ftp://IP/  用户名：ftpuser 密码：ftpuser

# 7.测试文件上传
# curl -T box.log -u ftpuser:ftpuser ftp://39.134.153.56/ 
# curl -T localfile -u name:passwd ftp://upload_site:port/path/

# [root@sdjn-fhcdn-oth-lgs056-5288-a2201 ~]# ssh 39.134.153.55 -p49721
# root@39.134.153.55's password: 
# Last login: Wed May 16 10:45:24 2018
# Login success. All activity will be monitored and reported 
# [root@sdjn-fhcdn-oth-mms055-rh2288h-a2201 ~]# ftp miguvideolog.cmvideo.cn
