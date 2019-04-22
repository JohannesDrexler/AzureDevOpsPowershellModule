[cmdletbinding()]
param()

Remove-Module DevOpsModule -ErrorAction Ignore
Import-Module $PSScriptRoot\..\src\DevOpsModule.psd1

$tasks = Get-DistributedTasks

$buildDefinitionReferences = Get-BuildDefinitions
foreach($buildDefRef in $buildDefinitionReferences)
{
    $buildDef = Get-BuildDefinition -projectNameOrId ($buildDefRef.project.id) -definitionId ($buildDefRef.id) -Verbose:$VerbosePreference
    #TODO: finish this script later
}