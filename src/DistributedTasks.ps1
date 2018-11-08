function Get-DistributedTasks
{
    [cmdletbinding()]
    param()

    $tasks = Get-DevOpsResponse -Url "/_apis/distributedtask/tasks"
    write-output ($tasks.Value)
}

#TODO: Remove-DistributedTask (taskId)
#TODO: Get-TaskGroups (projectNameOrId)
#TODO: Remove-TaskGroup (projectNameOrId, groupId)