#!/bin/bash 
# Script 4: Log File Analyzer 
# Usage: ./script4_log_analyzer.sh /var/log/syslog error 
LOGFILE=$1  KEYWORD=${2:-"error"} 
COUNT=0  TOTAL_LINES=0  WARNING_COUNT=0 
 
[ -z "$LOGFILE" ] && { echo "Usage: $0 <logfile> [keyword]"; exit 1; } 
 
# Do-while style retry if file not found 
ATTEMPTS=0 
while [ ! -f "$LOGFILE" ]; do 
  ATTEMPTS=$((ATTEMPTS+1)) 
  [ $ATTEMPTS -ge 3 ] && { echo "Max retries reached."; exit 1; } 
  read -p "File not found. Enter valid path: " LOGFILE 
done 
 
[ ! -s "$LOGFILE" ] && { echo "File is empty."; exit 0; } 
 
while IFS= read -r LINE; do 
  TOTAL_LINES=$((TOTAL_LINES+1)) 
  echo "$LINE" | grep -iq "$KEYWORD" && COUNT=$((COUNT+1)) 
  echo "$LINE" | grep -iq "warning"  && WARNING_COUNT=$((WARNING_COUNT+1)) 
done < "$LOGFILE" 
 
echo "Total lines : $TOTAL_LINES" 
echo "'$KEYWORD'  : $COUNT  ($((COUNT*100/TOTAL_LINES))%)" 
echo "Warnings    : $WARNING_COUNT" 
echo "--- Last 5 matches ---" 
grep -i "$KEYWORD" "$LOGFILE" | tail -5 | nl 

            


   
