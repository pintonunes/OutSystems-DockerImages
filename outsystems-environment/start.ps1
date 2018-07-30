# Import our module
Import-Module Outsystems.SetupTools

# Start SQL Express
Start-Service MSSQL`$SQLEXPRESS

# TODO: Clean the Database.

# Start Outsystems services
Start-OSServerServices

# Install the trial license
Install-OSPlatformLicense

# TODO: Monitor OS services (empty for now)
While($true){
    Start-Sleep -Seconds 15
}
