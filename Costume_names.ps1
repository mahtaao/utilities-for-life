# The location of the folder containing the files to be renamed
#The PowerShell script will:

#    Enumerate all files in your selected folder.
#    Skip non-PDF files.
#    Rename the PDF files to your format: "2022-01-01_Ram<FirstLetterOfFirstName>_TypeOfDocument.Pdf"

$FolderPath = "C:\Users\mahta\OneDrive\Documents\Work\chusj\access\ToSend"

# Your specific requirements
$startDate = "2024-02-26"
$lastName = "Ramezanain"

# Get all the PDF files in the folder
$files = Get-ChildItem -Path $FolderPath -Filter *.Pdf

foreach ($file in $files) {
    # Extract the current name without the extension (Pdf)
    $nameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    
    # Split and transform the original name to meet the 'Last Name and the first letter of the first name' requirement
    # For the purpose of this script, assume the first word before any character is the 'First name' and the name is the rest.
    # NOTE: Adjust the splitting logic to parse the `Type of document` IF it does not match your real file name formats.
    $documentType = $nameWithoutExtension

    # Update to match the previous comment.
    # Adjust this next logic line if further parsing of the file name for $firstName initial is needed.
    $firstInitial = '' # Assuming the first part of your specific name structure might be represented in the original file name if not, need user input

    # Form the new name
    $newName = $startDate + "_" + $lastName + $firstInitial + "_" + $documentType + ".Pdf"

    # Building the command for renaming the file; no file will be overwritten
    $newPath = Join-Path -Path $FolderPath -ChildPath $newName
    if (!(Test-Path $newPath)) {
        Rename-Item -Path $file.FullName -NewName $newPath
        Write-Output "Renamed `"$($file.Name)`" to `"$newName`""
    } else {
        Write-Warning "The file `"$newPath`" already exists."
    }
}
