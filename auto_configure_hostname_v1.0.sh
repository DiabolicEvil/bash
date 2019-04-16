###made by huyixin###
echo ---------------------------------
        IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'` ;
        echo 本机IP为:::
        echo $IP
echo 输入需要修改的hostname:::
read name

hostnamectl set-hostname $name





#echo 未修改
echo "$IP $name" >> /etc/hosts

cat /etc/hosts

su root


echo 已修改hostname和hosts

