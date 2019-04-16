#!/bin/bash
#shell菜单
function menu()
{
echo -e `date`
cat <<EOF
-----------------------------------
>>>菜单主页:
`echo -e "\033[35m 1)系统状态\033[0m"`
`echo -e "\033[35m 2)进程管理\033[0m"`
`echo -e "\033[35m 3)软件安装\033[0m"`
`echo -e "\033[35m 4)配置修改\033[0m"`
`echo -e "\033[35m 5)未开发\033[0m"`
`echo -e "\033[35m 6)未开发\033[0m"`
`echo -e "\033[35m 7)未开发\033[0m"`
`echo -e "\033[35m 8)未开发\033[0m"`
`echo -e "\033[35m 9)未开发\033[0m"`
`echo -e "\033[35m 0)返回主菜单\033[0m"`
`echo -e "\033[35m Q)退出\033[0m"`
EOF
read -p "请输入对应序列号：" num1
case $num1 in
    1)
    echo -e "\033[32m >>>系统状态-> \033[0m"
    system_menu
    ;;
    2)
    echo -e "\033[32m >>>进程管理-> \033[0m"
    server_menu
    ;;
    3)
    echo -e "\033[32m >>>软件安装-> \033[0m"
    software_menu
    ;;
    4)
    echo -e "\033[32m >>>配置修改-> \033[0m"
    config_menu
    ;;
    5)
    echo -e "\033[32m >>>未开发-> \033[0m"
    menu
    ;;
    6)
    echo -e "\033[32m >>>未开发-> \033[0m"
    menu
    ;;
    7)
    echo -e "\033[32m >>>未开发-> \033[0m"
    menu
    ;;
    8)
    echo -e "\033[32m >>>未开发-> \033[0m"
    menu
    ;;
    9)
    echo -e "\033[32m >>>未开发-> \033[0m"
    menu
    ;;
    0)
    echo ---------------------------------
    echo -e "\033[32m >>>已返回主菜单-> \033[0m"
    echo ---------------------------------
    menu
    ;;
    Q|q)
    echo -e "\033[32m--------退出--------- \033[0m"
    exit 0
    ;;
    *)
    echo -e "\033[31m err：请输入正确的编号\033[0m"
    menu
esac
}
function system_menu()
{
cat<<EOF
------------------------
********系统状态********
------------------------
1）agent 状态
2）rabbitmq 状态
3）tomcat 状态
4）mysql 状态
5）nginx 状态
X）返回上一级目录
------------------------
EOF
read -p "请输入编号:" num2
case $num2 in
    1)
    `echo -e "systemctl status agentd.service"`
    system_menu
    ;;
    2)
     `echo -e "systemctl status rabbitmq.service"`
    system_menu
    ;;
    3)
     `echo -e "systemctl status tomcat8.service"`
    system_menu
    ;;
    4)
     `echo -e "systemctl status mysqld.service"`
    system_menu
    ;;
    5)
     `echo -e "systemctl status nginx.service"`
    system_menu
    ;;
    x|X)
    echo -e "\033[32m---------返回上一级目录------->\033[0m"
    menu
    ;;
    *)
    echo -e "请输入正确编号"
    system_menu
esac
}
function server_menu()
{
cat<<EOF
------------------------
1）开启服务
2）停止服务
X）返回上一级目录
------------------------
EOF
read -p "请输入编号:" num3
case $num3 in
        1)
        op_menu
        ;;
        2)
        op_menu1
        ;;
        x|X)
        echo -e "\033[32m-- -----返回上一级目录---------> \033[0m"
        menu
        ;;
        *)
        echo -e "请输入正确编号"
        system_menu
esac
}

function op_menu()
{
cat<<EOF
------------------------
1）开启agent服务
2）开启rabbitmq服务
3）开启tomcat服务
X）返回上一级目录
------------------------
EOF
read -p "请输入编号:" num4
case $num4 in
        1)
    `echo -e "systemctl start agentd.service"`
    op_menu
        ;;
        2)
    `echo -e "systemctl start rabbitmq.service"`
        op_menu
    ;;
    3)
    `echo -e "systemctl start tomcat8.service"`
        op_menu
        ;;
        x|X)
        echo -e "\033[32m--------返回上一级目录------->\033[0m"
        server_menu
        ;;
        *)
        echo -e "请输入正确编号"
    op_menu
esac
}
function op_menu1()
{
cat<<EOF
------------------------
1）停止agent服务
2）停止rabbitmq服务
3）停止tomcat服务
X）返回上一级目录
------------------------
EOF
read -p "请输入编号:" num5
case $num5 in
        1)
        `echo -e "systemctl stop agentd.service"`
        op_menu1
        ;;
        2)
        `echo -e "systemctl stop rabbitmq.service"`
        op_menu1
        ;;
        3)
        `echo -e "systemctl stop tomcat8.service"`
        op_menu1
        ;;
        x|X)
        `echo -e "\033[32m >>>返回上一级目录---> \033[0m"`
        server_menu
        ;;
        *)
        echo -e "请输入正确编号"
        op_menu1
esac
}

function software_menu()
{
cat<<EOF
------------------------
1）升级agent
2）升级fums
3）全新安装agent
4）全新安装fums
0）返回主菜单
X）返回上一级目录
------------------------
EOF
read -p "请输入编号:" num6
case $num6 in
        1)
        echo "开始升级agent"
        sh auto.upgrade.fonsview.agent.sh
        ;;
        2)
        echo "开始升级fums"
        sh auto.upgrade.fonsview.fums.sh
        ;;
        3)
        `echo -e "systemctl stop rabbitmq.service"`
        op_menu1
        ;;
        4)
        `echo -e "systemctl stop rabbitmq.service"`
        op_menu1
        ;;
        0)
        echo ---------------------------------
        echo -e "\033[32m >>>已返回主菜单-> \033[0m"
        echo ---------------------------------
        menu
        ;;
        x|X)
        `echo -e "\033[32m >>>返回上一级目录---> \033[0m"`
        server_menu
        ;;
        *)
        echo -e "请输入正确编号"
        op_menu1
esac
}
menu
