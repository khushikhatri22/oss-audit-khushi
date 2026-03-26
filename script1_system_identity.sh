#!/bin/bash
# Script 1: System Identity Report - Khushi Khatri [24bai10311]
# Concepts: variables, echo, $(cmd sub)

echo "============================================="
echo "Open Source Audit - Khushi Khatri"
echo "Software: VLC"
echo "============================================="
KERNEL=$(uname -r)
USERNAME=$(whoami)
UPTIME=$(uptime -p)
echo "Kernel: $KERNEL | User: $USERNAME | Uptime: $UPTIME"
echo "============================================="
