#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\dmz\mail\blue_team_6_maillog.json"

$batch = 100000
$json_data = @()
$i = 0
Get-Content $infile -ReadCount $batch |
    ForEach {

             $log = $_ | ConvertFrom-Json
          
           
             $webtraffic = $log | Where-Object {$_.fromhost_ip -eq "10.7.106.12" }
            
                                                
             $json_data = $json_data + $webtraffic
             
            
             Echo $i
             $i++
            # $_ -match $match_regex -NotMatch $header_regex -Replace $replace_regex ,'$1' | Out-File $path\$outfile -Append
    }

    $json_data |ConvertTo-Json | Out-File $outfile -Append
    Echo "json data written in file"