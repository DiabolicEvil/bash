#!/bin/bash
# modify system password by username
username=$1
password=$2
echo $password | passwd --stdin $username
