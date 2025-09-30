#!/bin/bash

# --- CONFIGURATION ---
# Replace these dates with your actual dates in YYYY-MM-DD format
BIRTHDAY="2006-10-29"           # Your birthday
LINUX_START_DATE="2024-10-02"   # Date you started using Linux (or a different milestone)
# ---------------------

# --- FUNCTION TO CALCULATE AND FORMAT TIME ---
calculate_time_diff() {
    START_DATE=$1
    
    # Calculate seconds since the epoch for the start date and now
    # Note: GitHub Actions run in UTC
    START_SECONDS=$(date -d "$START_DATE" +%s)
    NOW_SECONDS=$(date +%s)

    # Calculate difference in seconds
    DIFF_SECONDS=$((NOW_SECONDS - START_SECONDS))

    # Convert seconds to days, hours, and minutes
    DAYS=$((DIFF_SECONDS / 86400))
    REMAINDER=$((DIFF_SECONDS % 86400))
    HOURS=$((REMAINDER / 3600))
    MINUTES=$(( (REMAINDER % 3600) / 60 ))

    echo "$DAYS Days $HOURS Hrs $MINUTES Mins"
}

# --- CALCULATE VALUES ---
NEW_BIRTHDAY_UPTIME=$(calculate_time_diff "$BIRTHDAY")
NEW_LINUX_JOURNEY=$(calculate_time_diff "$LINUX_START_DATE")

echo "Birthday Uptime: $NEW_BIRTHDAY_UPTIME"
echo "Linux Journey: $NEW_LINUX_JOURNEY"

# --- UPDATE README.md ---

# 1. Pattern for Birthday Uptime (clock icon)
SED_PATTERN_BIRTHDAY="s|<img src=\"https:\/\/cdn.jsdelivr.net\/npm\/feather-icons@4.28.0\/dist\/icons\/clock.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> uptime: .*|<img src=\"https:\/\/cdn.jsdelivr.net\/npm\/feather-icons@4.28.0\/dist\/icons\/clock.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> uptime: $NEW_BIRTHDAY_UPTIME|g"

# 2. Pattern for New Metric (calendar/activity icon)
# NOTE: You must add a new line for the Linux Journey to your README first!
# I'll use the activity icon (<img src=".../activity.svg" ...) for this new line.
SED_PATTERN_LINUX="s|<img src=\"https:\/\/cdn.jsdelivr.net\/npm\/feather-icons@4.28.0\/dist\/icons\/activity.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> journey: .*|<img src=\"https:\/\/cdn.jsdelivr.net\/npm\/feather-icons@4.28.0\/dist\/icons\/activity.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> journey: $NEW_LINUX_JOURNEY|g"

# Apply both replacements to README.md
# We're running sed with two separate expressions (-e)
sed -i.bak -e "$SED_PATTERN_BIRTHDAY" -e "$SED_PATTERN_LINUX" README.md

# Clean up the backup file
rm README.md.bak

echo "README updated successfully."
