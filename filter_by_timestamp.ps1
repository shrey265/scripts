#$time_reported = "2019-03-19T11:00:06+01:00"
#$time_generated = "2019-03-19T11:00:06.844109+01:00"
#$timestamp = 1552989606844


#$time_reported =  $time_reported.Substring(17,$time_reported.Length-23)
#$time_generated =  $time_generated.Substring(17,$time_generated.Length-23)


#$time_difference = [double]$time_generated - [double]$time_reported
#Echo $time_difference

#$log_timestamp = $timestamp - $time_difference
#Echo $log_timestamp





$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\dmz\mail\blue_team_6_maillog.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\dmz\mail\blue_team_6_mailattack.json"



$json_data = Get-Content $infile | ConvertFrom-Json
$webtraffic = $json_data | Where-Object { ($_.timestamp - ( [double]$_.timegenerated.Substring(17,$_.timegenerated.Length-23) - [double]$_.timereported.Substring(17,$_.timereported.Length-23) ) ) -ge 1553070620856 -and ($_.timestamp - ( [double]$_.timegenerated.Substring(17,$_.timegenerated.Length-23) - [double]$_.timereported.Substring(17,$_.timereported.Length-23) ) ) -le 1553070626341 }
$webtraffic |ConvertTo-Json | Out-File $outfile -Append