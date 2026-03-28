#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Description: Loops through important Linux directories, reports
#              their permissions and disk usage, and checks for
#              Git's configuration directory.
# =============================================================

# --- List of important system directories to audit ---
# This is a Bash array — values enclosed in parentheses, space-separated.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var")

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR                        "
echo "============================================================"
echo ""
echo "  Auditing $(echo ${#DIRS[@]}) directories on $(hostname)"
echo "  Date: $(date '+%d %B %Y %H:%M:%S')"
echo ""
echo "------------------------------------------------------------"
printf "  %-20s %-15s %-20s %-10s\n" "DIRECTORY" "PERMISSIONS" "OWNER:GROUP" "SIZE"
echo "------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do

    # Check if directory exists using the -d test
    if [ -d "$DIR" ]; then
        # ls -ld gives a long listing of the directory itself (not its contents)
        # awk extracts specific fields from the output:
        #   $1 = permissions string (e.g., drwxr-xr-x)
        #   $3 = owner username
        #   $4 = group name
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        OWNER_GROUP="$OWNER:$GROUP"

        # du -sh gives disk usage in human-readable format (-h)
        # The 2>/dev/null suppresses 'Permission denied' errors
        # cut -f1 extracts just the size field (before the tab)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # printf formats the output into aligned columns
        printf "  %-20s %-15s %-20s %-10s\n" "$DIR" "$PERMS" "$OWNER_GROUP" "${SIZE:-N/A}"

    else
        # This directory does not exist on this system
        printf "  %-20s [DOES NOT EXIST ON THIS SYSTEM]\n" "$DIR"
    fi

done

echo "------------------------------------------------------------"
echo ""

# --- Check Git-specific directories and files ---
echo "============================================================"
echo "  GIT CONFIGURATION AUDIT"
echo "============================================================"
echo ""

# Git stores its configuration in multiple locations.
# We check each one and print its permissions if found.
GIT_CONFIGS=(
    "/etc/gitconfig"         # System-wide Git config (affects all users)
    "$HOME/.gitconfig"       # User-level Git config (affects current user only)
    "$HOME/.config/git"      # XDG-standard Git config directory
)

echo "  Checking Git configuration locations:"
echo ""

for CONFIG in "${GIT_CONFIGS[@]}"; do
    if [ -f "$CONFIG" ]; then
        # File exists — show permissions
        PERMS=$(ls -lh "$CONFIG" | awk '{print $1}')
        SIZE=$(ls -lh "$CONFIG" | awk '{print $5}')
        echo "  [FOUND] $CONFIG"
        echo "          Permissions: $PERMS  |  Size: $SIZE"
        echo ""
    elif [ -d "$CONFIG" ]; then
        # Directory exists — show permissions
        PERMS=$(ls -ld "$CONFIG" | awk '{print $1}')
        echo "  [FOUND] $CONFIG (directory)"
        echo "          Permissions: $PERMS"
        echo ""
    else
        echo "  [MISSING] $CONFIG — not configured on this system"
        echo ""
    fi
done

# --- Check if git binary exists and print its permissions ---
GIT_BIN=$(which git 2>/dev/null)   # Locate the git binary

echo "------------------------------------------------------------"
echo "  GIT BINARY"
echo "------------------------------------------------------------"
if [ -n "$GIT_BIN" ]; then
    PERMS=$(ls -lh "$GIT_BIN" | awk '{print $1}')
    SIZE=$(ls -lh "$GIT_BIN" | awk '{print $5}')
    OWNER=$(ls -lh "$GIT_BIN" | awk '{print $3}')
    echo "  Binary  : $GIT_BIN"
    echo "  Owner   : $OWNER"
    echo "  Perms   : $PERMS"
    echo "  Size    : $SIZE"
    echo ""
    echo "  Note: Git is owned by root and executable by all users (755)."
    echo "  This is standard — it needs no elevated privileges to run."
else
    echo "  Git binary not found in PATH."
fi

echo ""
echo "============================================================"
echo "  PERMISSION LEGEND"
echo "============================================================"
echo "  r = read  |  w = write  |  x = execute  |  - = no permission"
echo "  [owner][group][others] — e.g. rwxr-xr-x = 755"
echo "============================================================"
