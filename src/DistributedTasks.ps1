function Get-DistributedTasks
{
    [cmdletbinding()]
    param()

    $tasks = Get-DevOpsResponse -Url "/_apis/distributedtask/tasks"
    write-output ($tasks.Value)
}

function Remove-DistributedTask
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [System.Guid]$taskId
    )

    Get-DevOpsResponse -Url "/_apis/distributedtask/tasks/$($taskId)?api-version=4.1" -method DELETE | Out-Null
}

#TODO: Get-TaskGroups (projectNameOrId)
#TODO: Remove-TaskGroup (projectNameOrId, groupId)