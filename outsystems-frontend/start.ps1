[CmdletBinding()]
Param(

    [Parameter()]
    [string]$OSController,

    [Parameter()]
    [string]$OSPrivateKey,

    [Parameter()]
    [ValidateSet('SQL','SQLExpress','AzureSQL')]
    [string]$OSDBProvider='SQL',

    [Parameter()]
    [ValidateSet('SQL','Windows')]
    [string]$OSDBAuth='SQL',

    [Parameter(Mandatory=$true)]
    [string]$OSDBServer,

    [Parameter()]
    [string]$OSDBCatalog='outsystems',

    [Parameter(Mandatory=$true)]
    [string]$OSDBSAUser,

    [Parameter(Mandatory=$true)]
    [string]$OSDBSAPass,

    [Parameter(Mandatory=$true)]
    [string]$OSDBSessionServer,

    [Parameter()]
    [string]$OSDBSessionCatalog='osSession',

    [Parameter()]
    [string]$OSDBSessionUser='OSSTATE',

    [Parameter(Mandatory=$true)]
    [string]$OSDBSessionPass,

    [Parameter()]
    [string]$OSDBAdminUser='OSADMIN',

    [Parameter()]
    [string]$OSDBAdminPass,

    [Parameter()]
    [string]$OSDBRuntimeUser='OSRUNTIME',

    [Parameter(Mandatory=$true)]
    [string]$OSDBRuntimePass,

    [Parameter()]
    [string]$OSDBLogUser='OSLOG',

    [Parameter(Mandatory=$true)]
    [string]$OSDBLogPass,

    [Parameter()]
    [string]$OSInstallDir="$Env:ProgramFiles\OutSystems",

    [Parameter()]
    [string]$OSLicensePath
)
# -- Configure environment
$ConfigToolArgs = @{

    Controller          = $OSController
    PrivateKey          = $OSPrivateKey

    DBProvider          = $OSDBProvider
    DBAuth              = $OSDBAuth

    DBServer            = $OSDBServer
    DBCatalog           = $OSDBCatalog
    DBSAUser            = $OSDBSAUser
    DBSAPass            = $OSDBSAPass

    DBSessionServer     = $OSDBSessionServer
    DBSessionCatalog    = $OSDBSessionCatalog
    DBSessionUser       = $OSDBSessionUser
    DBSessionPass       = $OSDBSessionPass

    DBAdminUser         = $OSDBAdminUser
    DBAdminPass         = $OSDBAdminPass
    DBRuntimeUser       = $OSDBRuntimeUser
    DBRuntimePass       = $OSDBRuntimePass
    DBLogUser           = $OSDBLogUser
    DBLogPass           = $OSDBLogPass
}
# Import outsytem PS module
Import-Module Outsystems.SetupTools

# Configure environment
Invoke-OSConfigurationTool @ConfigToolArgs -Verbose

# Disable OS Controller service
Get-Service -Name "OutSystems Deployment Controller Service" | Stop-Service -WarningAction SilentlyContinue
Set-Service -Name "OutSystems Deployment Controller Service" -StartupType "Disabled"

# Wait for service center to be published
While ( -not $(Get-OSPlatformVersion -ErrorAction SilentlyContinue) ) {
    Write-Output "Waiting for service center to be published"
    Start-Sleep -s 15
}
Write-Output "Service Center available. Waiting more 15 seconds for full initialization"
Start-Sleep -s 15

# -- System tunning
Set-OSServerPerformanceTunning

# -- Security settings
Set-OSServerSecuritySettings

# TODO: Monitor OS services (empty for now)
While($true){
    Start-Sleep -Seconds 15
}

