# ------------- Outsystems environment configuration  ------------------
# The version of the platform that will be installed.
$OSPlatformVersion='10.0.823.0'
$OSDevEnvironmentVersion='10.0.825.0'

# Where the platform will be installed.
$OSInstallDir="$Env:ProgramFiles\OutSystems"

# Log location
$OSLogPath="$Env:Windir\Temp\OutsystemsInstall"

# Set to true if you want to see verbose output in the console
$Verbose=$true

# ------------- Outsystems environment configuration ------------------

# -- Import module from Powershell Gallery
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Remove-Module Outsystems.SetupTools -ErrorAction SilentlyContinue
Install-Module Outsystems.SetupTools -Force
Import-Module Outsystems.SetupTools

# -- Start logging
Set-OSInstallLog -Path $OSLogPath -File "InstallLog-$(get-date -Format 'yyyyMMddHHmmss').log" -Verbose:$Verbose

# -- Install PreReqs
Install-OSPlatformPreReqs -MajorVersion "$(([System.Version]$OSPlatformVersion).Major).$(([System.Version]$OSPlatformVersion).Minor)" -InstallIISMgmtConsole:$false -Verbose:$Verbose

# -- Download and install OS Server and Dev environment from repo
Install-OSPlatformServer -Version $OSPlatformVersion -InstallDir $OSInstallDir -Verbose:$Verbose
Install-OSDevEnvironment -Version $OSDevEnvironmentVersion -InstallDir $OSInstallDir -Verbose:$Verbose

# -- Configure windows firewall
Set-OSPlatformWindowsFirewall -Verbose:$Verbose

# -- Disable IPv6
Disable-OSIPv6 -Verbose:$Verbose
