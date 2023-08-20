#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\data.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\usr\admin4\blue_team_6_admin4_traffic.json"

$batch = 1000
$filters = '"destinationIPv4Address":"10.6.4.49"'
$i = 0
Get-Content $infile -ReadCount $batch |
    ForEach {
          
           
           #  $webtraffic = $log | Where-Object {$_.destinationIPv4Address -eq '9.66.11.14' }
                                                
             
             $webtraffic = $_ | Select-String -pattern $filters -SimpleMatch
             $webtraffic | Add-Content $outfile 
            
             Echo $i
             $i++
            # $_ -match $match_regex -NotMatch $header_regex -Replace $replace_regex ,'$1' | Out-File $path\$outfile -Append
    }