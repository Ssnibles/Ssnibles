#!/bin/bash

# --- CONFIGURATION ---
# YYYY-MM-DD format
BIRTHDAY="2006-10-29"           # Birthday
LINUX_START_DATE="2024-10-02"   # Date since I started using Linux
# ---------------------

# --- FUNCTION TO CALCULATE AND FORMAT TIME ---
calculate_time_diff() {
    START_DATE=$1
    
    # Calculate seconds since the epoch for the start date and now
    # Note: GitHub Actions run in UTC
    START_SECONDS=$(date -d "$START_DATE" +%s)
    NOW_SECONDS=$(date +%s)

    # Calculate difference in seconds
    # (Using absolute value if you ever need to handle future dates)
    DIFF_SECONDS=$((NOW_SECONDS - START_SECONDS))

    # Convert seconds to days only
    DAYS=$((DIFF_SECONDS / 86400))

    echo "$DAYS Days"
}

# --- CALCULATE VALUES ---
NEW_BIRTHDAY_UPTIME=$(calculate_time_diff "$BIRTHDAY")
NEW_LINUX_JOURNEY=$(calculate_time_diff "$LINUX_START_DATE")

echo "Birthday Uptime: $NEW_BIRTHDAY_UPTIME"
echo "Linux Journey: $NEW_LINUX_JOURNEY"

# --- UPDATE README.md ---

# 1. Pattern for Birthday Uptime (mantelpiece clock emoji)
SED_PATTERN_BIRTHDAY="s|^\\([[:space:]]*\\)🕰️ uptime:\\([[:space:]]*\\).*|\\1🕰️ uptime:\\2$NEW_BIRTHDAY_UPTIME|g"

# 2. Pattern for Linux Journey (battery emoji)
SED_PATTERN_LINUX="s|^\\([[:space:]]*\\)🔋 journey:\\([[:space:]]*\\).*|\\1🔋 journey:\\2$NEW_LINUX_JOURNEY|g"

# Apply both replacements to README.md
# We're running sed with two separate expressions (-e)
sed -i.bak -e "$SED_PATTERN_BIRTHDAY" -e "$SED_PATTERN_LINUX" README.md

# Clean up the backup file
rm README.md.bak

echo "README updated successfully."
