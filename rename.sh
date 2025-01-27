#!/bin/bash

# Function to rename files and folders with numeric prefixes
rename_files() {
    echo "Renaming files and folders..."

    current_dir=$(pwd)

    # Separate visible folders and files into two lists, sorted by creation time
    folders=$(find "$current_dir" -maxdepth 1 -type d ! -name '.*' -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)
    files=$(find "$current_dir" -maxdepth 1 -type f ! -name '.*' -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)

    # Find the highest existing numeric prefix
    max_existing_number=0
    for item in $folders $files; do
        base_name=$(basename "$item")
        if [[ $base_name =~ ^([0-9]+)\..* ]]; then
            number=${BASH_REMATCH[1]}
            if (( number > max_existing_number )); then
                max_existing_number=$number
            fi
        fi
    done

    # Initialize counter starting from the next available number
    counter=$((max_existing_number + 1))

    # Rename folders with priority
    for folder in $folders; do
        base_name=$(basename "$folder")
        if [[ ! $base_name =~ ^[0-9]+\..* ]] && [[ ! $base_name =~ ^\..* ]]; then
            new_name="$counter.$base_name"
            mv "$folder" "$(dirname "$folder")/$new_name"
            counter=$((counter + 1))
        fi
    done

    # Rename files with remaining numbers
    for file in $files; do
        base_name=$(basename "$file")
        if [[ ! $base_name =~ ^[0-9]+\..* ]] && [[ ! $base_name =~ ^\..* ]]; then
            new_name="$counter.$base_name"
            mv "$file" "$(dirname "$file")/$new_name"
            counter=$((counter + 1))
        fi
    done

    echo "Renaming complete!"

    # List files and directories sorted numerically by their names
    sorted_items=$(ls -1v)
    echo "$sorted_items"
}

# Function to remove numeric prefixes from files and folders
anti_rename() {
    echo "Removing numeric prefixes..."

    current_dir=$(pwd)

    # Find all files and folders starting with a numeric prefix
    items=$(find "$current_dir" -maxdepth 1 -regex '.*/[0-9]+\..*')

    # Loop through the items and rename them
    for item in $items; do
        base_name=$(basename "$item")
        new_name=$(echo "$base_name" | sed 's/^[0-9]\+\.//')
        mv "$item" "$(dirname "$item")/$new_name"
    done

    echo "Prefix removal complete!"

    # List files and directories sorted numerically by their names
    sorted_items=$(ls -1v)
    echo "$sorted_items"
}

# Main script logic
if [[ "$1" == "rename" ]]; then
    rename_files
elif [[ "$1" == "anti-rename" ]]; then
    anti_rename
else
    echo "Usage: rename.sh [rename|anti-rename]"
    echo "  rename      - Add numeric prefixes to files and folders based on creation time."
    echo "  anti-rename - Remove numeric prefixes from files and folders."
fi
