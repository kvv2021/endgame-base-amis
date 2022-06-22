# Check for connection from Strigo for RDP
$maxRetries = 5; $retryCount = 0; $completed = $false
while (-not $established) {
    if (Get-NetTcpConnection | Where {$_.LocalPort -eq 3389 -and $_.State -eq "Established"}) {
     Write-Verbose "Strigo established a connection for Remote Desktop, setting firewall rules and prepping Fakenet."

     # Grab the public IP responsible for the connection and alter the firewall rule for RDP
     $publicIP = Get-NetTcpConnection | Where {$_.LocalPort -eq 3389 -and $_.State -eq "Established"} | Select-Object -ExpandProperty RemoteAddress
     Set-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -RemoteAddress $publicIP

     # Add the IP address to Fakenet Denylist
     Add-Content -Path "C:\fakenet1.4.11\fakenet1.4.11\configs\default.ini" -Value "HostBlackList: $publicIP"
     $established = $true
    }
    else {
        if ($retryCount -ge $maxRetries) {
            throw "Strigo hasn't established a connection yet"
        } else {
            Write-Verbose "No connection, retrying..."
            Start-Sleep '10'
            $retryCount++
        }
    }
}   