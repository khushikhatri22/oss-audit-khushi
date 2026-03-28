#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Reg No: [Your Registration Number]
# Course: Open Source Software | OSS NGMC Capstone
# Description: Checks if a FOSS package is installed, shows its
#              version and metadata, and prints a philosophy note
#              using a case statement.
# =============================================================

# --- Set the package name to inspect ---
# Git is our chosen software. On Debian/Ubuntu it's 'git'.
# On Red Hat/CentOS/Fedora it's also 'git'.
PACKAGE="git"

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR — $PACKAGE                  "
echo "============================================================"
echo ""

# --- Detect which package manager is available on this system ---
# This uses an if-elif chain to check for common package managers.
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"        # Debian/Ubuntu systems use dpkg
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"         # Red Hat/CentOS/Fedora use rpm
else
    PKG_MANAGER="unknown"     # Fallback if neither is found
fi

echo "  Detected package manager: $PKG_MANAGER"
echo ""

# --- Check if the package is installed using if-then-else ---
echo "------------------------------------------------------------"
echo "  INSTALLATION STATUS"
echo "------------------------------------------------------------"

if [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg -l lists packages; grep filters for our package name
    # The 2>/dev/null suppresses any error messages
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  [INSTALLED] $PACKAGE is installed on this system."
        echo ""
        echo "  Package Details:"
        # dpkg -s shows full package info; grep filters relevant fields
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Package|Version|Maintainer|Homepage|Description)" | \
            sed 's/^/    /'   # sed adds indentation for readability
    else
        echo "  [NOT FOUND] $PACKAGE is NOT installed."
        echo "  To install on Debian/Ubuntu, run:"
        echo "    sudo apt update && sudo apt install $PACKAGE"
        exit 1
    fi

elif [ "$PKG_MANAGER" = "rpm" ]; then
    # rpm -q checks if a package is installed
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  [INSTALLED] $PACKAGE is installed on this system."
        echo ""
        echo "  Package Details:"
        # rpm -qi gives detailed package info; grep filters key fields
        rpm -qi "$PACKAGE" | grep -E "^(Name|Version|License|Summary|URL)" | \
            sed 's/^/    /'
    else
        echo "  [NOT FOUND] $PACKAGE is NOT installed."
        echo "  To install on Red Hat/Fedora, run:"
        echo "    sudo dnf install $PACKAGE"
        exit 1
    fi

else
    # Fallback: try 'git --version' which works on any system with git
    if command -v git &>/dev/null; then
        echo "  [INSTALLED] $PACKAGE is available on this system."
        GIT_VERSION=$(git --version)
        echo "  Version info: $GIT_VERSION"
    else
        echo "  [NOT FOUND] $PACKAGE is NOT installed."
        exit 1
    fi
fi

echo ""

# --- Show installed binary location ---
echo "------------------------------------------------------------"
echo "  BINARY LOCATION"
echo "------------------------------------------------------------"
GIT_PATH=$(which git 2>/dev/null)   # which finds the path to the executable
if [ -n "$GIT_PATH" ]; then
    echo "  Git binary found at: $GIT_PATH"
    # ls -lh shows file size and permissions in human-readable format
    ls -lh "$GIT_PATH" | awk '{print "  Size: "$5"  |  Permissions: "$1"  |  Modified: "$6,$7,$8}'
fi
echo ""

# --- Case statement: philosophy note based on package name ---
# The case statement matches the package name to a message.
# This demonstrates the case construct required by the assignment.
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"
echo ""

case $PACKAGE in
    git)
        echo "  Git — Version control born from necessity, not profit."
        echo ""
        echo "  Linus Torvalds built Git in 2005 after BitKeeper revoked"
        echo "  free access to the Linux kernel team. The lesson: any tool"
        echo "  you cannot study or own can be used against you. Git is"
        echo "  licensed under GPL v2 — the same license as Linux itself."
        echo "  It guarantees that no company can ever lock the world's"
        echo "  developers out of their own version control system again."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server — the web server that built the open internet."
        echo ""
        echo "  Apache was one of the first major open-source success stories,"
        echo "  proving that community-built software could outcompete proprietary"
        echo "  alternatives at scale. Licensed under Apache 2.0."
        ;;
    mysql|mariadb)
        echo "  MySQL/MariaDB — open source at the heart of millions of apps."
        echo ""
        echo "  MySQL's dual-licensing story (GPL + commercial) shows that open"
        echo "  source and commercial viability are not opposites. MariaDB was"
        echo "  born as a community fork after Oracle acquired MySQL, demonstrating"
        echo "  the power of the GPL's freedom to fork."
        ;;
    vlc)
        echo "  VLC — built by students in Paris who just wanted to watch TV."
        echo ""
        echo "  VLC was created by students at École Centrale Paris to stream"
        echo "  campus television. Released under LGPL/GPL, it became the most"
        echo "  downloaded media player in the world. Proof that solving a real"
        echo "  problem in the open produces software that outlives its creators."
        ;;
    firefox)
        echo "  Firefox — a nonprofit fighting for an open web."
        echo ""
        echo "  Born from the ashes of Netscape, Firefox is backed by Mozilla,"
        echo "  a nonprofit whose mission is keeping the internet open. Without"
        echo "  Firefox, the web browser market would be a monopoly. It is proof"
        echo "  that open-source advocacy has a place in standards and markets."
        ;;
    python3|python)
        echo "  Python — a language shaped entirely by community."
        echo ""
        echo "  Guido van Rossum created Python to be readable and open. Governed"
        echo "  by the Python Software Foundation, it has become one of the most"
        echo "  used languages in the world — entirely through community contribution."
        ;;
    *)
        echo "  $PACKAGE — an open-source tool contributing to the commons."
        echo ""
        echo "  Every open-source project, no matter how small, is a contribution"
        echo "  to the shared foundation that all software builds on."
        ;;
esac

echo ""
echo "============================================================"
