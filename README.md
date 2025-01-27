# ShellScripts: File Renaming Script 

## Overview
This Python script helps you manage file and folder names by adding or removing numeric prefixes based on their creation time. It's designed for convenience, automation, and simplicity.

**Main Advantage**: This script makes navigating directories in the terminal faster and more efficient. By adding numeric prefixes, you can simply type the index and press `Tab` for auto-completion, saving time compared to typing entire file or folder names.

---

## Command Syntax

### **Available Options**

#### 1. **rename**
- **Functionality**: Adds numeric prefixes to files and folders in the current directory.
- **How It Works**: Prefixes are based on creation timestamps.
- **Naming Format**: `[number]_originalname`
- **Example**:
  - 📄 `01_document.txt`
  - 🖼️ `02_images`
- **Details**:
  - 🛠️ Preserves original file extensions.
  - ⚠️ Skips files that already have numeric prefixes.

#### 2. **anti-rename**
- **Functionality**: Removes numeric prefixes from files and folders.
- **How It Works**: Only affects items with the pattern `[numbers]_filename`.
- **Example**:
  - 🔄 `01_document.txt` → `document.txt`
- **Details**:
  - ✂️ Removes only leading numbers and underscores.
  - 🚫 Won't modify files without numeric prefixes.

#### 3. **--help**
- **Functionality**: Displays a user-friendly help message.
- **Use Case**: Refer to this for quick guidance on the command syntax and options.

---

## Important Details

### **What the Script Processes**
- ✅ Files and folders in the **current directory**.
- ✅ Items **without numeric prefixes** (for `rename`).
- ✅ Items **with numeric prefixes** (for `anti-rename`).
- ✅ All file types and extensions.

### **What the Script Skips**
- ❌ **Hidden files** (starting with `.`).
- ❌ Files in **subdirectories**.
- ❌ Files **already numbered** (during `rename`).
- ❌ Files **without numbers** (during `anti-rename`).

---

## Best Practices
- 🔒 **Backup First**: Always backup your files before running the script.
- 📖 **Run `--help`**: Verify the command syntax before using the script.
- 🧪 **Test Small**: Test on a small set of files before performing large-scale operations.
- 📂 **Directory Scope**: Remember, the script only affects the **current directory**.

---

## Error Prevention
This script is built with error-handling features to ensure a smooth experience:
- 🛡️ **Parameter Validation**: Ensures valid inputs for commands.
- 📝 **Usage Instructions**: Provides clear guidance for users.
- 🔢 **Duplicate Prevention**: Avoids duplicate numbering when renaming.
- 💾 **Extension Safety**: Maintains original file extensions to avoid accidental changes.

---

## Technical Notes

### **Help Message Implementation**
The `print_help()` function is implemented using Python's built-in `print()` with the following parameters:
- **Default Separator**: `sep=" "` (single space).
- **Default Line Ending**: `end="\n"` (new line).
- **Output Destination**: `file=None` (standard output).
- **No Force Flush**: `flush=False` (buffered output).

This ensures the help message is well-formatted, easy to read, and suitable for command-line usage.

---

### **Closing Notes**
This script is a powerful yet simple tool to organize your file names efficiently. Use it carefully and follow the best practices to get the most out of it.

Ready to simplify your file organization? Start by running `--help` and explore the possibilities!

