#es!/bin/bash

# Function to rename files and folders with numeric prefixes
function Rename-Files {
    Write-Host "Renaming files and folders..."

    $currentDir = Get-Location

    # Separate visible folders and files into two lists, sorted by creation time
    $folders = Get-ChildItem -Path $currentDir -Directory | Where-Object { $_.Name -notmatch '^\.' } | Sort-Object CreationTime
    $files = Get-ChildItem -Path $currentDir -File | Where-Object { $_.Name -notmatch '^\.' } | Sort-Object CreationTime

    # Initialize counter
    $counter = 1

    # Rename folders with priority
    foreach ($folder in $folders) {
        if ($folder.Name -notmatch '^[0-9]+\..*') {
            Rename-Item -Path $folder.FullName -NewName ("$counter.$($folder.Name)")
            $counter++
        }
    }

    # Rename files with remaining numbers
    foreach ($file in $files) {
        if ($file.Name -notmatch '^[0-9]+\..*') {
            Rename-Item -Path $file.FullName -NewName ("$counter.$($file.Name)")
            $counter++
        }
    }

    Write-Host "Renaming complete!"
}

# Function to remove numeric prefixes from files and folders
function Anti-Rename {
    Write-Host "Removing numeric prefixes..."

    $currentDir = Get-Location

    # Find all files and folders starting with a numeric prefix
    $items = Get-ChildItem -Path $currentDir | Where-Object { $_.Name -match '^[0-9]+\..*' }

    # Loop through the items and rename them
    foreach ($item in $items) {
        $newName = $item.Name -replace '^[0-9]+\.', ''
        Rename-Item -Path $item.FullName -NewName $newName
    }

    Write-Host "Prefix removal complete!"
}

# Example usage
# Rename-Files
# Anti-Rename
