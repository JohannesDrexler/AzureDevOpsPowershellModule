[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$targetDirectory = "$Env:ProgramFiles\WindowsPowerShell\Modules\"
$targetDirectory = Join-Path $targetDirectory "DevOpsModule"

if (Test-Path $targetDirectory)
{
    Get-ChildItem $targetDirectory | remove-item
}
else 
{
    new-item $targetDirectory -ItemType Directory
}

Get-ChildItem .\src | copy-item -Destination $targetDirectory -Recurse