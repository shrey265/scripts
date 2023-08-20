#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\data.json"
$path = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.WinlogEntry (1)\cz.muni.csirt.WinlogEntry\usr\admin2\blue_team_"

$batch = 100000
#$filters = '"host_ip":"10.7.106.22"'
$i = 0

for($j=1;$j -le 6 ;$j++){
    $outfile = "$($path)$($j)_usradmin2_winlog.json"

    $filters = '"host_ip":"10.7.10'+"$($j)"+'.47"'
   
    Get-Content $infile -ReadCount $batch |
    ForEach {
          
           
           #  $webtraffic = $log | Where-Object {$_.destinationIPv4Address -eq '9.66.11.14' }
                                                
             
             $webtraffic = $_ | Select-String -pattern $filters -SimpleMatch
             $webtraffic | Add-Content $outfile 
            
             Echo $i
             $i++
            # $_ -match $match_regex -NotMatch $header_regex -Replace $replace_regex ,'$1' | Out-File $path\$outfile -Append
    }
}

