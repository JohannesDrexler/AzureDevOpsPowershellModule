function Get-Projects
{
    [cmdletbinding()]
    param()

    $projects = Get-DevOpsResponse -Url "/_apis/projects"
    Write-Output ($projects.Value)
}

function Get-ProjectProperties
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [guid]$projectId
    )

    $projectProperties = Get-DevOpsResponse -Url "/_apis/projects/$projectId/properties" -apiVersion "5.0-preview.1"
    Write-Output ($projectProperties.Value)
}