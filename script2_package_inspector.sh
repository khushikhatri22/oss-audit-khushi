#!/bin/bash 
# Script 2: FOSS Package Inspector 
PACKAGE="git" 
 
if command -v dpkg &>/dev/null; then PKG_MANAGER="dpkg" 
elif command -v rpm  &>/dev/null; then PKG_MANAGER="rpm" 
else PKG_MANAGER="unknown"; fi 
 
if [ "$PKG_MANAGER" = "dpkg" ]; then 
  if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then 
    dpkg -s "$PACKAGE" | grep -E '^(Package|Version|Homepage)' 
  else echo "NOT installed"; exit 1; fi 
elif [ "$PKG_MANAGER" = "rpm" ]; then 
  rpm -qi "$PACKAGE" | grep -E '^(Name|Version|License)' 
else 
  command -v git && git --version || exit 1 
fi 
 
GIT_PATH=$(which git 2>/dev/null) 
ls -lh "$GIT_PATH" | awk '{print "Perms:"$1" Size:"$5}' 
 
case $PACKAGE in 
  git)    echo "Git: version control born from necessity, not profit." ;; 
  httpd)  echo "Apache: the web server that built the open internet." ;; 
  mysql)  echo "MySQL: open source at the heart of millions of apps." ;; 
  vlc)    echo "VLC: built by students, used by the whole world." ;; 
  firefox)echo "Firefox: a nonprofit fighting for an open web." ;; 
  *)      echo "$PACKAGE: contributing to the open-source commons." ;; 
esac 
 
    

