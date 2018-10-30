function Get-DistributedTasks
{
    [cmdletbinding()]
    param()

    $tasks = Get-DevOpsResponse -Url "/_apis/distributedtask/tasks"
    write-output ($tasks.Value)
}