#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Description: Displays a welcome screen with system information
#              and open-source license details for the OS.
# =============================================================

# --- Student & project variables ---
STUDENT_NAME="Khushi Khatri"           # Replace with your name
SOFTWARE_CHOICE="Git"                     # Our chosen open-source software

# --- Gather system information using command substitution $() ---
KERNEL=$(uname -r)                         # Linux kernel version
DISTRO=$(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"')
                                           # Distribution name from /etc/os-release
USER_NAME=$(whoami)                        # Currently logged-in user
HOME_DIR=$HOME                             # Home directory of current user
UPTIME=$(uptime -p)                        # Human-readable uptime (e.g., "up 2 hours")
CURRENT_DATE=$(date '+%A, %d %B %Y')       # Formatted date: Day, DD Month YYYY
CURRENT_TIME=$(date '+%H:%M:%S')           # Current time in HH:MM:SS format
HOSTNAME=$(hostname)                       # System hostname
ARCH=$(uname -m)                           # System architecture (e.g., x86_64)

# --- Detect OS license (Linux kernel is licensed under GPL v2) ---
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Print the header banner ---
echo "============================================================"
echo "          OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT        "
echo "============================================================"
echo ""

# --- Student and project info section ---
echo "  Student  : $STUDENT_NAME"
echo "  Software : $SOFTWARE_CHOICE"
echo "  Date     : $CURRENT_DATE"
echo "  Time     : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------"

# --- System details section ---
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Hostname      : $HOSTNAME"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Architecture  : $ARCH"
echo ""

# --- User details section ---
echo "------------------------------------------------------------"
echo "  USER INFORMATION"
echo "------------------------------------------------------------"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo ""

# --- Uptime section ---
echo "------------------------------------------------------------"
echo "  SYSTEM UPTIME"
echo "------------------------------------------------------------"
echo "  System has been running: $UPTIME"
echo ""

# --- License note section ---
echo "------------------------------------------------------------"
echo "  OPEN SOURCE LICENSE NOTE"
echo "------------------------------------------------------------"
echo "  This Linux operating system is covered by:"
echo "  $OS_LICENSE"
echo ""
echo "  This means you have the freedom to:"
echo "    * Run the OS for any purpose"
echo "    * Study and modify the source code"
echo "    * Redistribute copies freely"
echo "    * Share your modifications (also under GPL v2)"
echo ""
echo "  Our chosen software ($SOFTWARE_CHOICE) is also licensed"
echo "  under GPL v2 — the same license as the Linux kernel itself."
echo ""
echo "============================================================"
echo "  'Given enough eyeballs, all bugs are shallow.' — ESR"
echo "============================================================"
