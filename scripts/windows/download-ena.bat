# Downloads the Enhanced Network Driver

powershell [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://s3.amazonaws.com/ec2-windows-drivers-downloads/ENA/Latest/AwsEnaNetworkDriver.zip', 'C:\Windows\Temp\ENA.zip')
powershell -command "Expand-Archive C:\Windows\Temp\ENA.zip -DestinationPath C:\Windows\Temp\ENA"
powershell -EP Bypass -File C:\Windows\Temp\ENA\install.ps1