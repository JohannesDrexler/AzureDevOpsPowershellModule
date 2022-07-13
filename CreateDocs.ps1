[cmdletbinding()]
param()

$ErrorActionPreference = "Stop"

remove-module DevOpsModule -ErrorAction Ignore
import-module .\src\DevOpsModule.psd1

remove-item .\docs\commands -Force -Recurse -ErrorAction Ignore
new-item .\docs\commands -ItemType Directory | Out-Null

$commands = (get-module DevOpsModule).ExportedCommands
foreach($com in $commands.Keys)
{
    $helpContent = get-help $com -ErrorAction Ignore
    if($helpContent)
    {
        $helpContent | Out-File -FilePath ".\docs\commands\$com.txt"
    }
}