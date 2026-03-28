#!/bin/bash 
# Script 1: System Identity Report 
# Author: Khushi Khatri | Reg: 24BAI10311 
 
STUDENT_NAME="Khushi Khatri" 
SOFTWARE_CHOICE="Git" 
KERNEL=$(uname -r) 
DISTRO=$(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"') 
USER_NAME=$(whoami) 
HOME_DIR=$HOME 
UPTIME=$(uptime -p) 
CURRENT_DATE=$(date '+%A, %d %B %Y') 
CURRENT_TIME=$(date '+%H:%M:%S') 
HOSTNAME=$(hostname) 
ARCH=$(uname -m) 
OS_LICENSE="GNU General Public License v2 (GPL v2)" 
 
echo "====================================================" 
echo "   OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT" 
echo "====================================================" 
echo "  Student  : $STUDENT_NAME" 
echo "  Software : $SOFTWARE_CHOICE" 
echo "  Kernel   : $KERNEL | Arch: $ARCH" 
echo "  Distro   : $DISTRO" 
echo "  User     : $USER_NAME | Home: $HOME_DIR" 
echo "  Uptime   : $UPTIME" 
echo "  Date/Time: $CURRENT_DATE $CURRENT_TIME" 
echo "  OS License: $OS_LICENSE" 
echo "  Four Freedoms: Run | Study | Modify | Share" 
echo "====================================================" 
 

