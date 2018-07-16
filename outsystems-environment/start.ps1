# Import our module
Import-Module Outsystems.SetupTools 

# Install the trial license
Install-OSPlatformLicense

# TODO: Monitor OS services (empty for now)
While($true){
    Start-Sleep -Seconds 15
}
