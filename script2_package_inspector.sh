#!/bin/bash
# Script 2: FOSS Package Inspector - Khushi Khatri
# Concepts: if-else, case, package query

PACKAGE="vlc"
if command -v vlc >/dev/null 2>&1; then
  echo "$PACKAGE installed."
  vlc --version | head -1
else
  echo "$PACKAGE NOT installed."
fi
case $PACKAGE in vlc) echo "VLC: Free media player for all formats.";; esac
