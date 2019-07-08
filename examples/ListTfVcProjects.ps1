[cmdletbinding()]
param()

Remove-Module DevOpsModule -ErrorAction Ignore
Import-Module $PSScriptRoot\..\src\DevOpsModule.psd1

$projects = Get-Projects
foreach($proj in $projects)
{
    $properties = Get-ProjectProperties($proj.Id)
    $tfvcEnabled = $properties | Where-Object { $_.name -eq "System.SourceControlTfvcEnabled" }
    if(($tfvcEnabled -ne $null) -and ($tfvcEnabled.value -eq "true"))
    {
        Write-Host ($proj.name)
    }
}