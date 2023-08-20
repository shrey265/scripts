#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\blue_team_6_winlog_during_attack.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\blue_team_6_xmldata.xml"


$json_data = Get-Content $infile | ConvertFrom-Json
$xml = ""
ForEach ($object in $json_data){
   $xml = $xml + $object.xml
}
$xml = '<Logs>'+$xml+'</Logs>'
$xml | Out-File $outfile -Append