$maxRetries = 5; $retryCount = 0; $completed = $false
while (-not $established) {
    if (Get-NetTcpConnection | Where {$_.LocalPort -eq 3389 -and $_.State -eq "Established"}) {
     Write-Verbose "Strigo established a connection for Remote Desktop, setting firewall rules and prepping Fakenet."

     # Grab the public IP responsible for the connection and alter the firewall rule for RDP
     $publicIP = Get-NetTcpConnection | Where {$_.LocalPort -eq 3389 -and $_.State -eq "Established"} | Select-Object -ExpandProperty RemoteAddress
     Set-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -RemoteAddress $publicIP

     # Alter the firewall rule for WinRM for the SMP additionally to lock down this IP to only the SMP. 
	 Set-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -RemoteAddress $smpIP

     # Add the IP address we just parsed to Fakenet denylist
	 # Additionally add the SMP local IP address so that we can pass traffic to the SMP and write the rest of the config for Fakenet.

#Adding HostBlacklist line to prod.ini
$FileContent =
    Get-ChildItem "C:\fakenet1.4.11\fakenet1.4.11\configs\prod.ini" |
        Get-Content

$NewFileContent = @()

for ($i = 0; $i -lt $FileContent.Length; $i++) {
    if ($FileContent[$i] -match '\[ProxyTCPListener\]') {

        $NewFileContent += "HostBlacklist: $smpIP, $publicIP"
    }

    $NewFileContent += $FileContent[$i-1]
}

$NewFileContent |
    Out-File "C:\fakenet1.4.11\fakenet1.4.11\configs\prod.ini" 
    
    
New-NetFirewallRule -Program "C:\fakenet1.4.11\fakenet1.4.11\fakenet.exe" -Action Allow -Profile Public, Private -DisplayName "Allow fakenet TCP" -Description “Allows fakenet TCP” -Direction Inbound -Protocol TCP
New-NetFirewallRule -Program "C:\fakenet1.4.11\fakenet1.4.11\fakenet.exe" -Action Allow -Profile Public, Private -DisplayName "Allow fakenet UDP" -Description “Allows fakenet UDP” -Direction Inbound -Protocol UDP 
Set-Location  "C:\fakenet1.4.11\fakenet1.4.11"
.\fakenet.exe -c "C:\fakenet1.4.11\fakenet1.4.11\configs\prod.ini" -n


     $established = $true
    }
    else {
        if ($retryCount -ge $maxRetries) {
            throw "Strigo hasn't established a connection yet"
        } else {
            Write-Verbose "No connection, retrying..."
            Start-Sleep '30'
            $retryCount++
        }
    }
}
