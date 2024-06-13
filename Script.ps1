# Script to Copy Files Based on a List

# Define the path of the folder where the files are located
$sourceFolder = "C:\Users\youruser\yourfolderwherefilesarelocated"

# Define the path to the list of strings you need to search for
$fileListPath = "C:\Users\youruser\yourfolder\File.txt"

# Define the path of the folder where the selected files will be copied
$destinationFolder = "C:\Users\youruser\yourfolderwherefileswillbecopied"

# Ensure the destination folder exists, if not, create it
if (-Not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Read the list of search strings
$searchList = Get-Content -Path $fileListPath

# Get all files in the source folder
$allFiles = Get-ChildItem -Path $sourceFolder

# Loop through each search string and look for files that contain the string in their name
foreach ($searchString in $searchList) {
    foreach ($file in $allFiles) {
        if ($file.Name -like "*$searchString*") {
            $sourcePath = $file.FullName
            $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name

            Copy-Item -Path $sourcePath -Destination $destinationPath
        }
    }
}

Write-Host "File copy completed."
