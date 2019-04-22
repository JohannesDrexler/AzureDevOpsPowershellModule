function Get-BuildDefinitions
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$false)]
        [string]$projectNameOrId
    )

    if(!$projectNameOrId)
    {
        $projects = Get-Projects
        if($projects)
        {
            foreach($proj in $projects)
            {
                Write-Output (Get-BuildDefinitions -projectNameOrId ($proj.id))
            }
        }
    }
    else 
    {
        $definitions = Get-DevopsResponse -url "/$projectNameOrId/_apis/build/definitions?api-version=5.0"
        Write-Output ($definitions.value)
    }
}

function Get-BuildDefinition
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$projectNameOrId,

        [parameter(Mandatory=$true)]
        [int]$definitionId
    )

    $definition = Get-DevOpsResponse -url "/$projectNameOrId/_apis/build/definitions/$($definitionId)?api-version=5.0"
    Write-Output $definition
}

#TODO: Remove-BuildDefinition (projectNameOrId, definitionId)
#TODO: Get-Builds (projectNameOrId, definitionId)
#TODO: Get-Build (projectNameOrId, definitionid)
#TODO: Remove-Build (projectNameOrId, buildId)