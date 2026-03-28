#!/bin/bash 
# Script 5: Open Source Manifesto Generator 
# Alias concept (interactive-shell only, shown as function here): 
today() { date '+%d %B %Y'; } 
 
read -p "1. Open-source tool you use daily: " TOOL 
[ -z "$TOOL" ] && TOOL="Git" 
read -p "2. In one word, what does freedom mean to you? " FREEDOM 
[ -z "$FREEDOM" ] && FREEDOM="choice" 
read -p "3. Something you would build and share freely: " BUILD 
[ -z "$BUILD" ] && BUILD="a learning tool" 
 
OUTPUT="manifesto_$(whoami).txt" 
 
# String concatenation to build manifesto paragraphs 
> "$OUTPUT"   # Clear/create the file 
echo "=== MY OPEN SOURCE MANIFESTO === $(today)" >> "$OUTPUT" 
echo "" >> "$OUTPUT" 
echo "Every day I use $TOOL — built in the open by someone" >> "$OUTPUT" 
echo "who chose sharing over profit. I am the beneficiary." >> "$OUTPUT" 
echo "" >> "$OUTPUT" 
echo "Freedom, to me, means $FREEDOM. In software that means" >> "$OUTPUT" 
echo "the right to read, change, and share what runs on my machine." >> "$OUTPUT" 
echo "" >> "$OUTPUT" 
echo "I would build $BUILD and release it freely — because" >> "$OUTPUT" 
echo "the tools I learned from were given to me the same way." >> "$OUTPUT" 
echo "" >> "$OUTPUT" 
echo "Generated: $(date '+%d %B %Y at %H:%M:%S')" >> "$OUTPUT" 
 
echo "Manifesto saved to $OUTPUT" 
cat "$OUTPUT" 
 
