function Create-Tag
{
    [cmdletbinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [string]$name,

        [parameter(Mandatory=$true)]
        [string]$taggedObject,

        [parameter(Mandatory=$true)]
        [string]$objectId,

        [parameter(Mandatory=$true)]
        [string]$repositoryId

    )


    $tag = Get-DevOpsResponse -Url "/_apis/git/repositories/$repositoryId/annotatedtags"
    Write-Output ($tag.Value)
}