#!/bin/bash 
# Script 3: Disk and Permission Auditor 
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var") 
 
printf "%-20s %-15s %-20s %-10s\n" "DIRECTORY" "PERMISSIONS" "OWNER:GROUP" "SIZE" 
echo "------------------------------------------------------------" 
 
for DIR in "${DIRS[@]}"; do 
  if [ -d "$DIR" ]; then 
    PERMS=$(ls -ld "$DIR" | awk '{print $1}') 
    OWNER=$(ls -ld "$DIR" | awk '{print $3":"$4}') 
    SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1) 
    printf "%-20s %-15s %-20s %-10s\n" "$DIR" "$PERMS" "$OWNER" "${SIZE:-N/A}" 
  else 
    echo "$DIR does not exist on this system" 
  fi 
done 
 
# Check Git config files 
for CFG in /etc/gitconfig ~/.gitconfig ~/.config/git; do 
  [ -e "$CFG" ] && echo "[FOUND] $CFG: $(ls -ld $CFG | awk '{print $1}')" \ 
              || echo "[MISSING] $CFG" 
done 
 
    
