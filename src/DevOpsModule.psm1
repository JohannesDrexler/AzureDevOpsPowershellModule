class DevOpsConnection 
{
    [string]$InstanceUrl
    [string]$Token

    DevOpsConnection($InstanceUrl, $Token)
    {
        $this.InstanceUrl = $InstanceUrl
        $this.Token = $Token
    }
}

function Get-DevOpsConnection
{
    [cmdletbinding()]
    param()

    if (!$global:connection)
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

    if (Get-DevOpsConnection -ErrorAction SilentlyContinue)
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

    if ($global:connection)
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
        [string]$Url,

        [ValidateSet("GET","DELETE","PUT")]
        [parameter(Mandatory=$false)]
        [string]$method = "GET",

        [parameter(Mandatory=$false)]
        [string]$apiVersion = "6.0"
    )

    $erroractionpreference = "stop"

    $connection = Get-DevOpsConnection

    # Append api-version to url
    if (!$url.Contains("api-version"))
    {
        if( !$url.Contains("?"))
        {
            $url+="?api-version=$apiVersion"
        }
        else
        {
            $url+="&api-version=$apiVersion"
        }
    }

    $finalUrl = $connection.InstanceUrl + $Url
    Write-Verbose "RequestUrl -> $finalUrl"
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$connection.Token)))
    $result = Invoke-RestMethod -Uri $finalUrl -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Method $method
    if($result.GetType() -eq [string])
    {
        $result = ConvertFrom-JsonNewtonsoft -string $result
    }
    Write-Output $result
}

#include functions
."$PSScriptRoot\Builds.ps1"
."$PSScriptRoot\DistributedTasks.ps1"
."$PSScriptRoot\Projects.ps1"