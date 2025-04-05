#!/bin/bash

# --- base directory for projects---
PROJECTS_DIR="../projects"

# git clone target directory relative to the script's execution location
TARGET_DIR="$PROJECTS_DIR/htdocs/lms"
mkdir -p "$TARGET_DIR"

# --- Configuration ---
MOODLE_REPO="https://github.com/moodle/moodle.git"

# Log file relative to the script's execution location
LOG_FILE="../projects/moodle_clone_script.log"


# --- Pre-flight Checks ---

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed. Please install git and try again." >&2
    exit 1
fi

# --- Determine Latest Stable Moodle Tag ---
#+TODO: fix a stable tag for production use (not latest)
echo "Fetching latest stable Moodle tags from $MOODLE_REPO..."
# Get tags, sort by version descending, filter for stable vX.Y.Z format, get the top one
LATEST_STABLE_TAG=$(git ls-remote --tags --refs --sort='-v:refname' "$MOODLE_REPO" \
                    | grep -E 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$' \
                    | head -n 1 \
                    | sed 's:.*/::') # Extract tag name (e.g., v4.3.1)

if [ -z "$LATEST_STABLE_TAG" ]; then
    echo "Error: Could not determine the latest stable Moodle tag." >&2
    echo "Please check your internet connection and repository access." >&2
    exit 1
fi

echo "Latest stable Moodle tag found: $LATEST_STABLE_TAG"



# --- Prepare Target Directory ---

# Detect if the $PROJECTS_DIR exists
if [ ! -d "$PROJECTS_DIR" ]; then
    echo "Warning: Directory '$PROJECTS_DIR' does not exist. Creating it for continue."
fi


# Check if the target directory exists and is not empty
if [ -d "$TARGET_DIR" ] && [ "$(ls -A "$TARGET_DIR")" ]; then
    echo "Error: Target directory '$TARGET_DIR' already exists and is not empty." >&2
    echo "Please remove it or choose a different location." >&2
    exit 1
elif [ -e "$TARGET_DIR" ] && [ ! -d "$TARGET_DIR" ]; then
     echo "Error: '$TARGET_DIR' exists but is not a directory." >&2
     exit 1
fi


# --- Clone Moodle ---

echo "Cloning Moodle version $LATEST_STABLE_TAG into $TARGET_DIR..."
# Clone only the specific tag (--depth 1 for faster download without history)
git clone --branch "$LATEST_STABLE_TAG" --depth 1 "$MOODLE_REPO" "$TARGET_DIR"

# Check if cloning was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone Moodle repository." >&2
    exit 1
fi

echo "Moodle $LATEST_STABLE_TAG cloned successfully."



# --- Log the Operation ---

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S %Z') # Get current timestamp e.g., 2025-04-03 15:24:45 -03
LOG_ENTRY="[$TIMESTAMP] Cloned Moodle version $LATEST_STABLE_TAG from $MOODLE_REPO into $TARGET_DIR"


# Append log entry to the log file
echo "$LOG_ENTRY" >> "$LOG_FILE"

if [ $? -ne 0 ]; then
    echo "Warning: Could not write to log file '$LOG_FILE'." >&2
    # Don't exit, cloning succeeded, but logging failed
else
    echo "Log entry added to $LOG_FILE"
fi

echo "Script finished."
exit 0
