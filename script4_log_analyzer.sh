#!/bin/bash
# Script 4: Log Analyzer - Khushi Khatri
# Concepts: while read, counter, args

LOG=${1:-/var/log/syslog}
KEY=${2:-ERROR}
COUNT=0
while IFS= read -r line; do [[ $line =~ [Ee]$KEY ]] && ((COUNT++)); done < "$LOG"
echo "$KEY found $COUNT times in $LOG"
