###made by huyixin###
echo 该脚本会复制出templ后缀的文件
echo 例如:test.sh.templ执行后变为test.sh.templ和test.sh文件
echo 该脚本只适用于文件名中有两个.的文件 类似test.templ不会执行操作
echo 该操作会覆盖旧配置文件 如非全新安装 请勿执行
echo （可在grep "templ"后面添加|grep -v aaa.conf.templ等不选中该文件）
echo 请确认是否执行[输入y开始其他退出]:::
read choice
if [ $choice == y ];then
for f in $(ls -l | awk '{print $9}'| grep "templ" ) ;do f1=`echo $f | awk -F'.' '{print $1"."$2}'`;echo $f;echo $f1 ;echo y | cp $f $f1;done
echo finish
else
echo exit
exit 0
fi