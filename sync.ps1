#! /usr/bin/pwsh

$lbrynet = "/home/pkahle/source/lbry-sdk/lbry-venv/bin/lbrynet"
function search-claim {
    param(
        [string] $Channel=$Null
        # [string] $Query
    )
    
    $Params = @(
        "--channel=$Channel",
        $Query
    )
    & $lbrynet claim search "--channel=$Channel"
    write-host $lbrynet claim search "--channel=$Channel"
# write-host $Params
#     Invoke-Command -FilePath $lbrynet -ArgumentList $Params
}

search-claim -Channel "`@Deterrence-Dispensed"
search-claim -Channel "@Ivan's_CAD_Streams"