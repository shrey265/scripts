# Function to Split File
function Split-File
{
    param
    (
        [Parameter(Mandatory)]
        [String]
        $Path,
        $SavePath,
        [Int32]
        $PartSizeBytes = 1MB
    )
    try
    {
        # Get separate parts of filename to construct new names
        $NameWithoutExtension = [IO.Path]::GetFileNameWithoutExtension($Path)
        $ParentDirectory = [IO.Path]::GetDirectoryName($Path)
        $Extension = [IO.Path]::GetExtension($Path)

        # Calculate total number of chunks possible
        $OriginalFile = New-Object System.IO.FileInfo($Path)
        $TotalPartsCount = [int][Math]::Log10([int]($OriginalFile.Length / $PartSizeBytes) + 1) + 1
        $ReadFile = [IO.File]::OpenRead($Path)
        $Count = 0
        $Chunk = New-Object Byte[] $PartSizeBytes
        $DataLeftFlag = $true

        # Read chunks till data is left
        while($DataLeftFlag)
        {
            # read individual chunks
            $ReadBytes = $ReadFile.Read($Chunk, 0, $Chunk.Length)
            
            # create filenames for the chunks
            $chunkFileName = "$SavePath\$NameWithoutExtension.{0:D$TotalPartsCount}$Extension" -f $Count
            $Output = $Chunk

            # For the final part, where the chunksize is less
            if ($ReadBytes -ne $Chunk.Length)
            {
                $DataLeftFlag = $false # No more data
    
                # Use the final chunk as the last part by shrinking the bytesize
                $Output = New-Object Byte[] $ReadBytes
                [Array]::Copy($Chunk, $Output, $ReadBytes)
            }
   
            # save the chunk to a file
            [IO.File]::WriteAllBytes($chunkFileName, $Output)
            ++$Count
        }
        $ReadFile.Close()
    }
    catch
    {
        throw "Can't split file ${Path}: $_"
    }
}
#Create dialog box to open file
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
$null = $FileBrowser.ShowDialog()

# Ask for size # CHANGE THIS SECTION to ask for size in other units
# 1KB=1024Bytes, 1MB = 1024KB, 1GB = 1024TB
$NumMB = read-host -Prompt "Enter Size in MB"
$NumBytes = 1024*1024*($NumMB -as [int]) # This section converts the MB input to bytes

#Create dialog box to save file
Add-Type -AssemblyName System.Windows.Forms
$SaveFileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $SaveFileBrowser.ShowDialog()

# Call Split-File Function to Split file
Split-File -SavePath $SaveFileBrowser.SelectedPath  -Path $FileBrowser.FileName -PartSizeBytes $NumBytes -Verbose