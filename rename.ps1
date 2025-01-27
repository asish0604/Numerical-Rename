# Function to rename files and folders with numeric prefixes
function Rename-Files {
    Write-Host "Renaming files and folders..."

    $currentDir = Get-Location

    # Separate visible folders and files into two lists, sorted by creation time
    $folders = Get-ChildItem -Path $currentDir -Directory | Where-Object { $_.Name -notmatch '^\.' } | Sort-Object CreationTime
    $files = Get-ChildItem -Path $currentDir -File | Where-Object { $_.Name -notmatch '^\.' } | Sort-Object CreationTime

    # Find the highest existing numeric prefix
    $existingNumbers = @()
    $existingNumbers += $folders | Where-Object { $_.Name -match '^[0-9]+' } | ForEach-Object { [int]($_.Name -split '\.')[0] }
    $existingNumbers += $files | Where-Object { $_.Name -match '^[0-9]+' } | ForEach-Object { [int]($_.Name -split '\.')[0] }
    $maxExistingNumber = if ($existingNumbers) { $existingNumbers | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum } else { 0 }

    # Initialize counter starting from the next available number
    $counter = $maxExistingNumber + 1

    # Rename folders with priority
    foreach ($folder in $folders) {
        if ($folder.Name -notmatch '^[0-9]+\..*' -and $folder.Name -notmatch '^\..*') {
            Rename-Item -Path $folder.FullName -NewName ("$counter.$($folder.Name)")
            $counter++
        }
    }

    # Rename files with remaining numbers
    foreach ($file in $files) {
        if ($file.Name -notmatch '^[0-9]+\..*' -and $file.Name -notmatch '^\..*') {
            Rename-Item -Path $file.FullName -NewName ("$counter.$($file.Name)")
            $counter++
        }
    }

    Write-Host "Renaming complete!"

    # List files and directories sorted numerically by their names
    $sortedItems = Get-ChildItem | Sort-Object {
        if ($_.Name -match '^[0-9]+') {
            [int]($_.Name -split '\.')[0]
        } else {
            [int]::MaxValue
        }
    }

    # Display the sorted items
    $sortedItems | ForEach-Object { Write-Host $_.Name }
}

# Function to remove numeric prefixes from files and folders
# ...existing code...

function Anti-Rename {
    Write-Host "Removing numeric prefixes..."

    $currentDir = Get-Location

    # Find all files and folders starting with one or more digits followed by a dot
    $items = Get-ChildItem -Path $currentDir | Where-Object { $_.Name -match '^[0-9]+\.' }

    # Loop through them and remove that part of the name
    foreach ($item in $items) {
        $newName = $item.Name -replace '^[0-9]+\.', ''
        Rename-Item -Path $item.FullName -NewName $newName
    }

    Write-Host "Prefix removal complete!"

    # List files and directories sorted numerically by their names
    $sortedItems = Get-ChildItem | Sort-Object {
        if ($_.Name -match '^[0-9]+') {
            [int]($_.Name -split '\.')[0]
        } else {
            [int]::MaxValue
        }
    }

    # Display the sorted items
    $sortedItems | ForEach-Object { Write-Host $_.Name }
}

# ...existing code...

# Main script logic
if ($MyInvocation.InvocationName -eq ".\rename.ps1") {
    param (
        [string]$Action
    )

    switch ($Action) {
        "rename" { Rename-Files }
        "anti-rename" { Anti-Rename }
        default {
            Write-Host "Usage: rename.ps1 -Action [rename|anti-rename]"
            Write-Host "  rename      - Add numeric prefixes to files and folders based on creation time."
            Write-Host "  anti-rename - Remove numeric prefixes from files and folders."
        }
    }
}