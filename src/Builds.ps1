function Get-BuildDefinitions
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$false)]
        [string]$projectNameOrId
    )

    if (!$projectNameOrId)
    {
        $projects = Get-Projects

        if ($projects)
        {
            foreach ($proj in $projects)
            {
                Write-Output (Get-BuildDefinitions -projectNameOrId ($proj.id))
            }
        }
    }
    else 
    {
        $definitions = Get-DevopsResponse -url "/$projectNameOrId/_apis/build/definitions"
        Write-Output ($definitions.value)
    }
}

function Get-BuildDefinition
{
    [cmdletbinding()]
    param
    (
        
    )

    $definition = Get-DevOpsResponse -url "/$projectNameOrId/_apis/build/definitions/$($definitionId)"
    Write-Output $definition
}

function Get-Builds
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$projectNameOrId,

        [parameter(Mandatory=$false)]
        [int]$definitionId
    )

    $requestUrl = "/$projectNameOrId/_apis/build/builds"

    if ($definitionId -ne 0)
    {
        $requestUrl += "?definitions=$definitionId"
    }

    $builds = Get-DevOpsResponse -url $requestUrl
    Write-Output ($builds.value)
}

function Get-Build
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$projectNameOrId,

        [parameter(Mandatory=$true)]
        [int]$buildId
    )

    $build = Get-DevOpsResponse -url "/$projectNameOrId/_apis/build/builds/$buildId"
    Write-Output $build
}

function Remove-Build
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$projectNameOrId,

        [parameter(Mandatory=$true)]
        [int]$buildId
    )

    Get-DevOpsResponse -url "/$projectNameOrId/_apis/build/builds/$buildId" -method DELETE | Out-Null
}

#TODO: Remove-BuildDefinition (projectNameOrId, definitionId)