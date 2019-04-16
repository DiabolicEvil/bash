ip addr|去除inet6|去除127.0.0.1|去除192.168|选中inet|显示第二列|以/划分并取第一部分
ip addr|grep -v inet6|grep -v 127.0.0.1|grep -v 192.168|grep inet|awk '{print $2}'| cut -d / -f 1   