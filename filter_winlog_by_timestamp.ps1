$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\blue_team_6_winlog.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\blue_team_6_winlog_during_attack.json"



$json_data = Get-Content $infile | ConvertFrom-Json
$webtraffic = $json_data | Where-Object { $_.timestamp -ge 1553073223340 -and $_.timestamp -le 1553078173214}
$webtraffic |ConvertTo-Json |ForEach-Object { [Regex]::Replace($_, "\\u(?<Value>[a-zA-Z0-9]{4})", { param($m) ([char]([int]::Parse($m.Groups['Value'].Value, [System.Globalization.NumberStyles]::HexNumber))).ToString() } )} | Out-File $outfile -Append