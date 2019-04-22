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

    if(Get-DevOpsConnection -ErrorAction SilentlyContinue)
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

function Export-DevOpsConnection
{
    [cmdletbinding()]
    param()

    $connection = Get-DevOpsConnection
    $content = "$($connection.InstanceUrl)|$($connection.token)"
    $content | Set-Content -Path (Join-Path $env:TMP "DevOpsToken.txt")
}

function Import-DevOpsConnection
{
    [cmdletbinding()]
    param()

    $contentPath = Join-Path $env:TMP "DevOpsToken.txt"
    if(test-path $contentPath)
    {
        [string]$content = Get-Content $contentPath -Raw
        $contentSplits = $content.Split('|')
        Enter-DevOpsConnection -InstanceUrl $contentSplits[0] -Token $contentSplits[1]
    }
    else
    {
        Write-Warning "Unable to import DevOpsConnection"
    }
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
        [string]$method = "GET"
    )

    $erroractionpreference = "stop"

    $connection = Get-DevOpsConnection

    $finalUrl = $connection.InstanceUrl + $Url
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