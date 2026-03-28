#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Description: Asks the user three interactive questions and
#              generates a personalised open-source philosophy
#              statement, saving it to a .txt file.
# Concepts used: read, string concatenation, file output (>/>>) 
#                date command, conditional logic, aliases (noted)
# =============================================================

# --- Alias concept demonstration (via comment, as aliases are ---
# --- interactive-shell only and don't work in scripts directly) ---
# In an interactive shell you might set:
#   alias today='date "+%d %B %Y"'
#   alias mymanifesto='cat ~/manifesto_$(whoami).txt'
# We replicate this behaviour in the script using functions below.

# --- Helper function to replicate 'today' alias behaviour ---
today() {
    date '+%d %B %Y'    # Returns formatted date like "28 March 2026"
}

# --- Helper function to print a separator line ---
separator() {
    echo "------------------------------------------------------------"
}

# ============================================================
# WELCOME SCREEN
# ============================================================
clear   # Clear the terminal for a clean experience

echo "============================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR                      "
echo "       OSS NGMC Capstone — Script 5                         "
echo "============================================================"
echo ""
echo "  This script will generate a personalised open-source"
echo "  philosophy statement based on your answers."
echo ""
echo "  Answer three questions honestly."
echo "  Your manifesto will be saved to a .txt file."
echo ""
separator
echo ""

# ============================================================
# INTERACTIVE INPUT — using 'read' command
# ============================================================

# Question 1: A tool they use every day
read -p "  1. Name one open-source tool you use every day: " TOOL

# Input validation: if user left it blank, use a default
if [ -z "$TOOL" ]; then
    TOOL="Git"    # Default to Git (our chosen software)
    echo "     (No input given — using default: $TOOL)"
fi

echo ""

# Question 2: What freedom means to them
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Validate — trim spaces and default if empty
FREEDOM=$(echo "$FREEDOM" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
if [ -z "$FREEDOM" ]; then
    FREEDOM="choice"
    echo "     (No input given — using default: $FREEDOM)"
fi

echo ""

# Question 3: Something they would build and share
read -p "  3. Name one thing you would build and share freely: " BUILD

if [ -z "$BUILD" ]; then
    BUILD="a tool to help others learn to code"
    echo "     (No input given — using default: $BUILD)"
fi

echo ""

# --- Capture the student's username for the filename ---
AUTHOR=$(whoami)                          # Current logged-in user
DATE_TODAY=$(today)                       # Uses our 'today' function above
OUTPUT="manifesto_${AUTHOR}.txt"          # Output filename

echo ""
separator
echo "  Generating your manifesto..."
separator
echo ""

# ============================================================
# COMPOSE THE MANIFESTO
# ============================================================
# We use string concatenation and multiple echo statements
# redirected to the file with > (overwrite) and >> (append).

# '>' creates or overwrites the file with the first line
echo "============================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Written by: $AUTHOR" >> "$OUTPUT"
echo "  Date: $DATE_TODAY" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Paragraph 1: About the tool they use ---
PARA1="Every day, I reach for $TOOL — not because it was forced upon me,"
PARA1="$PARA1 but because someone, somewhere, chose to build it in the open"
PARA1="$PARA1 and share it with the world without asking for anything in return."
PARA1="$PARA1 I am the beneficiary of that generosity. The least I can do is"
PARA1="$PARA1 understand it — and carry it forward."

# Write paragraph 1 to the file using echo and >>
echo "$PARA1" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Paragraph 2: About what freedom means ---
PARA2="To me, freedom means $FREEDOM. In the context of software, that is not"
PARA2="$PARA2 an abstract idea — it is the right to read the code that runs on my"
PARA2="$PARA2 machine, to change it, to fix it, to share what I have learned. Software"
PARA2="$PARA2 that I cannot study is not mine, no matter who says I own it."
PARA2="$PARA2 The source code is the truth. Everything else is a label."

echo "$PARA2" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Paragraph 3: About what they would build ---
PARA3="If I had the skill and the time, I would build $BUILD — and I would"
PARA3="$PARA3 release it under an open license, because the tools I have used"
PARA3="$PARA3 to learn, to build, and to think were themselves given to me freely."
PARA3="$PARA3 That debt is not repaid by keeping things to myself."
PARA3="$PARA3 It is repaid by adding to the commons."

echo "$PARA3" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Closing statement ---
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "  'Given enough eyeballs, all bugs are shallow.' — Eric S. Raymond" >> "$OUTPUT"
echo "  'Free software is a matter of liberty, not price.' — Richard Stallman" >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Generated by: script5_manifesto_generator.sh" >> "$OUTPUT"
echo "  Timestamp: $(date '+%d %B %Y at %H:%M:%S')" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# ============================================================
# DISPLAY THE RESULT
# ============================================================
echo "  Your manifesto has been saved to: $OUTPUT"
echo ""
separator
echo ""

# cat reads and prints the file to the terminal
cat "$OUTPUT"

echo ""
separator
echo "  To read your manifesto again at any time, run:"
echo "    cat $OUTPUT"
echo ""
echo "  In an interactive shell you can set an alias like:"
echo "    alias mymanifesto='cat $OUTPUT'"
echo "    Then just type: mymanifesto"
echo ""
echo "============================================================"
