#!/bin/bash
# Script 3: Disk Auditor - Khushi Khatri
# Concepts: for loop, du/ls

DIRS="/etc /var/log /usr/bin"
echo "Audit Report"
for d in $DIRS; do
  if [ -d "$d" ]; then
    echo "$d: $(du -sh $d 2>/dev/null | cut -f1), perms: $(ls -ld $d | awk '{print $1" "$3}')"
  fi
done
