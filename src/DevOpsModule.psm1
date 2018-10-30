class DevOpsConnection 
{
    [string]$InstanceUrl
    [string]$Token

    DevOpsConnection($InstanceUrl,$Token)
    {
        $this.InstanceUrl = $InstanceUrl
        $this.Token = $Token
    }
}

function Get-DevOpsConnection
{
    [cmdletbinding()]
    param()

    if(!$global:connection)
    {
        Write-Error "No connection set. Use 'Enter-DevOpsConnection' to set a connection."
    }
    else
    {
        Write-Output $global:connection
    }
}

function Remove-DevOpsConnection
{
    [cmdletbinding()]
    param()

    if(Get-DevOpsConnection -ErrorAction Ignore)
    {
        Remove-Variable -Name "connection" -Scope "global"
        Write-Host "Removed connection"
    }
}

function Enter-DevOpsConnection
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$InstanceUrl,

        [parameter(Mandatory=$true)]
        [string]$Token
    )

    if($global:connection)
    {
        Write-Warning "There is already a connection set. Overwriting it now"
    }

    $connection = new-object DevOpsConnection($InstanceUrl,$Token)
    $global:connection = $connection
}

function Get-DevOpsResponse
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$Url
    )

    $erroractionpreference = "stop"

    if(!$global:connection)
    {
        Write-Error "No connection found. Use 'Enter-DevOpsConnection' to enter your connection"
    }

    $finalUrl = $global:connection.InstanceUrl + $Url
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$global:connection.Token)))
    $result = Invoke-RestMethod -Uri $finalUrl -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
    if($result.GetType() -eq [string])
    {
        $result = ConvertFrom-JsonNewtonsoft -string $result
    }
    Write-Output $result
}

#include functions
."$PSScriptRoot\DistributedTasks.ps1"