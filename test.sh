#!/bin/sh
myFile="/root/12323213  "

# 这里的-f参数判断$myFile是否存在
if [ ! -f "$myFile" ]; then
echo "success"
fi

