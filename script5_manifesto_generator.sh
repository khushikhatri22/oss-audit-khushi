#!/bin/bash
# Script 5: Manifesto - Khushi Khatri
# Concepts: read, concat, > file

read -p "Daily OSS tool? " t
read -p "Freedom= " f
read -p "Build/share? " b
cat > manifesto.txt <<E
My Manifesto: Use $t. Freedom:$f. Share:$b.
E
cat manifesto.txt
