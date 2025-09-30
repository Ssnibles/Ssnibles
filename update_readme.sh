#!/bin/bash

# Your date of birth in YYYY-MM-DD format
BIRTHDAY="1990-01-01" # <<< REPLACE THIS WITH YOUR REAL BIRTHDAY

# Calculate seconds since the epoch for the birthday and now
# Note: GitHub Actions run in UTC, so your birthday will be treated as UTC 00:00:00
BIRTH_SECONDS=$(date -d "$BIRTHDAY" +%s)
NOW_SECONDS=$(date +%s)

# Calculate difference in seconds
DIFF_SECONDS=$((NOW_SECONDS - BIRTH_SECONDS))

# Convert seconds to days, hours, and minutes
DAYS=$((DIFF_SECONDS / 86400)) # 86400 seconds in a day
REMAINDER=$((DIFF_SECONDS % 86400))
HOURS=$((REMAINDER / 3600)) # 3600 seconds in an hour
MINUTES=$(( (REMAINDER % 3600) / 60 ))

# Format the uptime string
NEW_UPTIME="$DAYS Days $HOURS Hrs $MINUTES Mins"

# Define the pattern to replace in your README (look for the "uptime:" line)
# We need to escape the '/' in the sed command
SED_PATTERN="s|<img src=\"https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/icons/clock.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> uptime: .*|<img src=\"https:\/\/cdn.jsdelivr.net\/npm\/feather-icons@4.28.0\/dist\/icons\/clock.svg\" width=\"16\" height=\"16\" style=\"filter: brightness(0) invert(1);\"\/> uptime: $NEW_UPTIME|g"

# Use sed to replace the line in README.md
# We're making a backup just in case
sed -i.bak "$SED_PATTERN" README.md

# Clean up the backup file
rm README.md.bak

echo "README updated with uptime: $NEW_UPTIME"
