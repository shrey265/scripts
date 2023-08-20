#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data.json"
$outfile1 = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data_third1.json"
$outfile2 = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data_third2.json"
$outfile3 = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.SyslogEntry\cz.muni.csirt.SyslogEntry\data.json\data_third3.json"

$batch = 100000
$json_data = @()
$i = 0
Get-Content $infile -ReadCount $batch |
    ForEach {

             $log = $_ | ConvertFrom-Json
             $json_data = $json_data + $log
             
             if($i -eq 20){
              $json_data | ConvertTo-Json | Out-File $outfile1 -Append
              $json_data = @()
             }
             elseif($i -eq 40){
              $json_data | ConvertTo-Json | Out-File $outfile2 -Append
              $json_data = @()
             }
             elseif($i -eq 59){
              $json_data | ConvertTo-Json | Out-File $outfile3 -Append
              $json_data = @()
             }
             Echo $i
             $i++

    }


    Echo "json data written in files"