#$path = "E:\Documents\Projects\ESPS\Dev\DataFiles\DimProductionOrderOperation"
$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\partial.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\test_data.json"

$batch = 1000

$i = 0
Get-Content $infile -ReadCount $batch |
    ForEach {

             $log = $_ | ConvertFrom-Json
          
           
             $webtraffic = $log | Where-Object {$_.destinationIPv4Address -eq '9.66.11.14' }
                                                
         
             $webtraffic |ConvertTo-Json | Add-Content $outfile 
            
             Echo $i
             $i++
            # $_ -match $match_regex -NotMatch $header_regex -Replace $replace_regex ,'$1' | Out-File $path\$outfile -Append
    }