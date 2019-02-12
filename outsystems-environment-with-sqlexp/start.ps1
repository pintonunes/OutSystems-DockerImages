
# Start SQL Express and RabbitMQ
Write-Output "Starting MSSQL server and RabbitMQ"
Start-Service 'RabbitMQ' -ErrorAction Stop 
Start-Service 'MSSQL$SQLEXPRESS' -ErrorAction Stop

# Wait for RabbitMQ to be available
$credentials = New-Object System.Management.Automation.PSCredential ('admin', $(ConvertTo-SecureString $env:OSDBSAPass -AsPlainText -Force))
while(-not($response))
{
    Write-Output 'Waitting for RabbitMQ to start'
    try
    {
        $response = Invoke-RestMethod -Uri 'http://localhost:15672/api/overview' -Credential $credentials -Method GET -ContentType "application/json"
    } 
    catch
    {
        Start-Sleep -Seconds 5
    }
}
Write-Output 'RabbitMQ started!!'

# Clean the database from existing servers
Write-Output 'Cleaning up the database'
Invoke-Sqlcmd -Query "DELETE FROM [outsystems].[dbo].[ossys_Parameter] WHERE HOST IS NOT NULL AND HOST != ''" -ServerInstance $env:OSDBServer -Database outsystems -Username $env:OSDBSAUser -Password $env:OSDBSAPass -ErrorAction Stop
Invoke-Sqlcmd -Query "DELETE FROM [outsystems].[dbo].[ossys_Server]" -ServerInstance $env:OSDBServer -Database outsystems -Username $env:OSDBSAUser -Password $env:OSDBSAPass -ErrorAction Stop

# Run the configuration tool to register this container on the database. This will start the outsystems services also
Write-Output 'Running the configuration tool'
Set-OSServerConfig -Apply -ErrorAction Stop

# Get IP on Hyper-V isolation
$IPAddress = ( Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected" } ).IPv4Address.IPAddress
if ($IPAddress)
{
    Write-Output "Outsystems environment is available at: http://$IPAddress/ServiceCenter"
}

# TO REMOVE: Install a trial license
Install-OSPlatformLicense

# Container Started
Write-Output 'Container Started!!!'

# TODO: Monitor OS services (empty for now)
While($true){
    Start-Sleep -Seconds 15
}
