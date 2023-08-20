$LogFilePath = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data.json"
$FileStream = New-Object -TypeName IO.FileStream -ArgumentList ($LogFilePath), ([System.IO.FileMode]::Open), ([System.IO.FileAccess]::Read), ([System.IO.FileShare]::ReadWrite);
$ReadLogFile = New-Object -TypeName System.IO.StreamReader -ArgumentList ($FileStream, [System.Text.Encoding]::ASCII, $true);
 
[int]$LineNumber = 0;
 
# Read Lines
while (!$ReadLogFile.EndOfStream)
{
	$LogContent = $ReadLogFile.ReadLine()
	$LineNumber++
    Echo $LineNumber
}
 
$ReadLogFile.Close()