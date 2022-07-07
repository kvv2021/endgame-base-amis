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
	 
     Add-Content -Path "C:\fakenet1.4.11\fakenet1.4.11\configs\prod.ini" -Value "
HostBlackList: $smpIP, $publicIP
[ProxyTCPListener]
Enabled:     True
Protocol:    TCP
Listener:    ProxyListener
Port:        38926
Listeners:   HTTPListener, RawListener, FTPListener, DNSListener, POPListener, SMTPListener, TFTPListener, IRCListener, BITSListener
Hidden:      False

[ProxyUDPListener]
Enabled:     True
Protocol:    UDP
Listener:    ProxyListener
Port:        38926
Listeners:   RawListener, DNSListener, TFTPListener, FTPListener
Hidden:      False

[Forwarder]
Enabled:     False
Port:        8080
Protocol:    TCP
ProcessWhiteList: chrome.exe
Hidden:      False

[RawTCPListener]
Enabled:     True
Port:        1337
Protocol:    TCP
Listener:    RawListener
UseSSL:      No
Timeout:     10
Hidden:      False
# To read about customizing responses, see docs/CustomResponse.md
# Custom:    sample_custom_response.ini

[RawUDPListener]
Enabled:     True
Port:        1337
Protocol:    UDP
Listener:    RawListener
UseSSL:      No
Timeout:     10
Hidden:      False
# To read about customizing responses, see docs/CustomResponse.md
# Custom:    sample_custom_response.ini

[FilteredListener]
Enabled:     False
Port:        31337
Protocol:    TCP
Listener:    RawListener
UseSSL:      No
Timeout:     10
ProcessWhiteList: ncat.exe, nc.exe
HostBlackList: 5.5.5.5
Hidden:      False

[DNS Server]
Enabled:     True
Port:        53
Protocol:    UDP
Listener:    DNSListener
ResponseA:   192.0.2.123
ResponseMX:  mail.evil2.com
ResponseTXT: FAKENET
NXDomains:   0
Hidden:      False

[HTTPListener80]
Enabled:     True
Port:        80
Protocol:    TCP
Listener:    HTTPListener
UseSSL:      No
Webroot:     defaultFiles/
Timeout:     10
#ProcessBlackList: dmclient.exe, OneDrive.exe, svchost.exe, backgroundTaskHost.exe, GoogleUpdate.exe, chrome.exe
DumpHTTPPosts: Yes
DumpHTTPPostsFilePrefix: http
Hidden:      False
# To read about customizing responses, see docs/CustomResponse.md
# Custom:    sample_custom_response.ini

[HTTPListener443]
Enabled:     True
Port:        443
Protocol:    TCP
Listener:    HTTPListener
UseSSL:      Yes
Webroot:     defaultFiles/
DumpHTTPPosts: Yes
DumpHTTPPostsFilePrefix: http
Hidden:      False

[SMTPListener]
Enabled:     True
Port:        25
Protocol:    TCP
Listener:    SMTPListener
UseSSL:      No
Hidden:      False

[FTPListener21]
Enabled:     True
Port:        21
Protocol:    TCP
Listener:    FTPListener
UseSSL:      No
FTProot:     defaultFiles/
PasvPorts:   60000-60010
Hidden:      False
Banner:      !generic
ServerName:  !gethostname

[FTPListenerPASV]
Enabled:     True
Port:        60000-60010
Protocol:    TCP
Hidden:      False

[IRCServer]
Enabled:     True
Port:        6667
Protocol:    TCP
Listener:    IRCListener
UseSSL:      No
Banner:      !generic
ServerName:  !gethostname
Timeout:     30
Hidden:      False

[TFTPListener]
Enabled:     True
Port:        69
Protocol:    UDP
Listener:    TFTPListener
TFTPRoot:    defaultFiles/
Hidden:      False
TFTPFilePrefix:  tftp

[POPServer]
Enabled:     True
Port:        110
Protocol:    TCP
Listener:    POPListener
UseSSL:      No
Hidden:      False"
     
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