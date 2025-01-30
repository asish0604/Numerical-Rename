import os
import sys
import re
from pathlib import Path

def rename_files():
    print("Renaming files and folders...")
    current_dir = Path('.')
    
    # Separate directories and files
    directories = [item for item in current_dir.iterdir() if item.is_dir()]
    files = [item for item in current_dir.iterdir() if item.is_file()]
    
    # Sort by creation time
    directories.sort(key=lambda x: x.stat().st_ctime)
    files.sort(key=lambda x: x.stat().st_ctime)
    
    counter = 1
    
    # Rename directories first
    for item in directories:
        # Skip hidden files, folders, system files like desktop.ini, and those with a numeric prefix followed by a dot
        if not item.name.startswith('.') and item.name.lower() != 'desktop.ini' and not re.match(r'^\d+\.', item.name):
            new_name = f"{counter}.{item.name}"
            item.rename(current_dir / new_name)
            print(f"Renamed directory: {item.name} -> {new_name}")
            counter += 1
        else:
            print(f"Skipping hidden, system, or prefixed file/folder: {item.name}")
    
    # Rename files next
    for item in files:
        # Skip hidden files, folders, system files like desktop.ini, and those with a numeric prefix followed by a dot
        if not item.name.startswith('.') and item.name.lower() != 'desktop.ini' and not re.match(r'^\d+\.', item.name):
            new_name = f"{counter}.{item.name}"
            item.rename(current_dir / new_name)
            print(f"Renamed file: {item.name} -> {new_name}")
            counter += 1
        else:
            print(f"Skipping hidden, system, or prefixed file/folder: {item.name}")

    print("Renaming complete!")

def anti_rename():
    print("Removing numeric prefixes...")
    current_dir = Path('.')
    items = list(current_dir.iterdir())

    for item in items:
        # Skip hidden files, folders, and system files like desktop.ini
        if not item.name.startswith('.') and item.name.lower() != 'desktop.ini':
            match = re.match(r'^\d+\.(.*)', item.name)
            if match:
                new_name = match.group(1)
                item.rename(current_dir / new_name)
                print(f"Renamed item: {item.name} -> {new_name}")
            else:
                print(f"No numeric prefix found: {item.name}")
        else:
            print(f"Skipping hidden or system file/folder: {item.name}")

    print("Anti-renaming complete!")

def print_help():
    print("Usage: rename.py [rename|anti-rename|--help]")
    print("  rename      - Add numeric prefixes to files and folders based on creation time.")
    print("  anti-rename - Remove numeric prefixes from files and folders.")
    print("  --help      - Show this help message.")

# Main script logic
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print_help()
        sys.exit(1)

    action = sys.argv[1]
    if action == "rename":
        rename_files()
    elif action == "anti-rename":
        anti_rename()
    elif action == "--help":
        print_help()
    else:
        print_help()
        sys.exit(1)