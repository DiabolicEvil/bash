#!/bin/sh
filename=media.log
filesize=`ls -l $filename | awk '{ print $5 }'`
maxsize=$((1024*10))
if [ $filesize -gt $maxsize ]
then
    echo "$filesize > $maxsize"
    mv media.log media"`date +%Y-%m-%d_%H:%M:%S`".log
else 
    echo "$filesize < $maxsize"

--------------------- 
作者：yingxian_Fei 
来源：CSDN 
原文：https://blog.csdn.net/smilefyx/article/details/22478107 
版权声明：本文为博主原创文章，转载请附上博文链接！