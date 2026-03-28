#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Description: Reads a log file line by line, counts matches for
#              a keyword, shows statistics, and prints the last 5
#              matching lines. Accepts filename and keyword as
#              command-line arguments.
# Usage: ./script4_log_analyzer.sh /var/log/syslog error
#        ./script4_log_analyzer.sh /var/log/auth.log failed
# =============================================================

# --- Command-line arguments ---
# $1 is the first argument (log file path)
# $2 is the second argument (keyword to search for)
LOGFILE=$1
KEYWORD=${2:-"error"}    # Default keyword is 'error' if none provided

# --- Counters for statistics ---
COUNT=0           # Lines matching the keyword
TOTAL_LINES=0     # Total lines in the file
WARNING_COUNT=0   # Lines containing 'warning' (bonus counter)

echo "============================================================"
echo "         LOG FILE ANALYZER — OSS Capstone                   "
echo "============================================================"
echo ""

# --- Validate input: check if a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo ""
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    echo "  Common log files to try:"
    echo "    /var/log/syslog      (Ubuntu/Debian)"
    echo "    /var/log/messages    (CentOS/RHEL)"
    echo "    /var/log/auth.log    (authentication events)"
    exit 1
fi

# --- Check if the file exists using the -f test ---
# The -f flag checks for a regular file (not a directory or device)
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # --- Do-while style retry loop ---
    # Bash does not have a native do-while, so we simulate it with
    # a while true loop and a break condition inside.
    ATTEMPTS=0
    MAX_ATTEMPTS=3

    while true; do
        ATTEMPTS=$((ATTEMPTS + 1))
        echo "  Retry attempt $ATTEMPTS of $MAX_ATTEMPTS."
        echo "  Please enter a valid log file path (or press Enter to skip):"
        read -r LOGFILE   # Read new input from the user

        # Break out of loop if user provides empty input (wants to quit)
        if [ -z "$LOGFILE" ]; then
            echo "  Exiting. No file to analyze."
            exit 1
        fi

        # Check if the new file exists
        if [ -f "$LOGFILE" ]; then
            echo "  File found: $LOGFILE"
            break   # Exit the loop — we have a valid file
        fi

        # If we have reached maximum attempts, exit
        if [ "$ATTEMPTS" -ge "$MAX_ATTEMPTS" ]; then
            echo "  Maximum retry attempts reached. Exiting."
            exit 1
        fi

        echo "  File '$LOGFILE' still not found."
    done
fi

echo "  Analyzing: $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo "  Started  : $(date '+%H:%M:%S')"
echo ""
echo "------------------------------------------------------------"

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: The file '$LOGFILE' is empty. Nothing to analyze."
    exit 0
fi

# --- Main analysis: while-read loop ---
# IFS= prevents leading/trailing whitespace from being stripped.
# -r flag prevents backslash escapes from being interpreted.
# We redirect the file into the loop with < "$LOGFILE".
while IFS= read -r LINE; do

    TOTAL_LINES=$((TOTAL_LINES + 1))   # Increment total line counter

    # --- Inner if-then: check if the line matches our keyword ---
    # grep -i makes the search case-insensitive
    # -q suppresses output (we only care about the exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment keyword match counter
    fi

    # --- Bonus: also count warnings (case-insensitive) ---
    if echo "$LINE" | grep -iq "warning"; then
        WARNING_COUNT=$((WARNING_COUNT + 1))
    fi

done < "$LOGFILE"

# --- Display summary statistics ---
echo "  ANALYSIS RESULTS"
echo "------------------------------------------------------------"
echo "  Total lines in file   : $TOTAL_LINES"
echo "  Lines with '$KEYWORD' : $COUNT"
echo "  Lines with 'warning'  : $WARNING_COUNT"
echo ""

# --- Calculate match percentage if total lines > 0 ---
if [ "$TOTAL_LINES" -gt 0 ]; then
    # Bash only does integer arithmetic; multiply by 100 first for percentage
    PERCENT=$(( (COUNT * 100) / TOTAL_LINES ))
    echo "  Match rate            : ${PERCENT}%"
fi

echo ""
echo "------------------------------------------------------------"
echo "  LAST 5 MATCHING LINES"
echo "------------------------------------------------------------"
echo ""

# --- Show last 5 lines containing the keyword ---
# grep -i = case-insensitive | tail -5 = last 5 results
# We number each result using a counter variable.
LINE_NUM=0
while IFS= read -r MATCH; do
    LINE_NUM=$((LINE_NUM + 1))
    echo "  [$LINE_NUM] $MATCH"
done < <(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

# Handle the case where there were no matches
if [ "$LINE_NUM" -eq 0 ]; then
    echo "  No lines matching '$KEYWORD' found."
fi

echo ""
echo "------------------------------------------------------------"
echo "  Analysis complete at $(date '+%H:%M:%S')"
echo "============================================================"
