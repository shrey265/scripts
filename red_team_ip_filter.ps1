$infile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\usr\admin4\blue_team_6_admin4_traffic.json"
$outfile = "C:\Users\sshre\OneDrive\Desktop\defense exercise\cz.muni.csirt.IPFlowEntry\cz.muni.csirt.IPFlowEntry\usr\admin4\blue_team_6_admin4_attack.json"

$batch = 100
$ip_ranges = (
('1.9.0.0','1.9.255.255'),
('27.111.240.0','27.111.255.255'),
('77.51.0.0','77.51.255.255'),
('81.17.0.0','81.17.15.255'),
('129.90.0.0','129.90.255.255'),
('193.151.128.0','193.151.159.255'),
('212.96.96.0','212.96.127.255'),
('5.23.128.0','5.23.255.255'),
('37.6.0.0','37.6.255.255'),
('78.177.0.0','78.177.255.255'),
('92.53.192.0','92.53.223.255'),
('130.255.32.0','130.255.63.255'),
('200.110.240.0','200.110.255.255'),
('213.5.0.0','213.5.7.255'),
('5.172.192.0','5.172.207.255'),
('37.32.0.0','37.32.31.255'),
('80.79.0.0','80.79.15.255'),
('110.5.80.0','110.5.95.255'),
('181.118.144.0','181.118.159.255'),
('202.2.96.0','202.2.127.255'),
('217.25.208.0','217.25.223.255'),
('27.3.0.0','27.3.31.255'),
('66.231.64.0','66.231.79.255'),
('80.93.176.0','80.93.191.255'),
('111.66.0.0','111.66.255.255'),
('188.40.0.0','188.40.255.255'),
('212.5.0.0','212.5.31.255'),
('219.15.224.0','219.15.239.255')
)

$i = 0
#$json_data = Get-Content $infile | ConvertFrom-Json

#Foreach ($object in $json_data) {

#    Foreach ($ip_range in $ip_ranges) {
#             if($object.sourceIPv4Address -gt $ip_range[0] -and $object.sourceIPv4Address -lt $ip_range[1]){
#                    $object | ConvertTo-Json | Out-File $outfile -Append
#                }
#         }
#         $i++
#         Echo $i

#}
$json_data = @()
Get-Content $infile -ReadCount $batch |
    ForEach {

             $log = $_ | ConvertFrom-Json
             
             Foreach ($ip_range in $ip_ranges){
                    $webtraffic = $log | Where-Object {$_.sourceIPv4Address -gt $ip_range[0] -and $_.sourceIPv4Address -lt $ip_range[1]  }
                   #$webtraffic |ConvertTo-Json | Add-Content $outfile 
                   $json_data = $json_data+$webtraffic
             }
        
            
             Echo $i
             $i++
            # $_ -match $match_regex -NotMatch $header_regex -Replace $replace_regex ,'$1' | Out-File $path\$outfile -Append
    }

    $json_data |ConvertTo-Json | Out-File $outfile -Append