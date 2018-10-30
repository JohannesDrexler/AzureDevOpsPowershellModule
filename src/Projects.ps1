function Get-Projects
{
    [cmdletbinding()]
    param()

    $projects = Get-DevOpsResponse -Url "/_apis/projects"
    Write-Output ($projects.Value)
}