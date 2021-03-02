#! /usr/bin/pwsh

$lbrynet = "/home/pkahle/source/lbry-sdk/lbry-venv/bin/lbrynet"
function search-claim {
    param(
        [string] $Channel=$Null,
        [int] $Page = $Null
    )
    # write-host "Page: $Page"
    if ($Page -eq 0){
        $items = New-Object System.Collections.ArrayList($null)
        $results = & $lbrynet claim search "--channel=$Channel"| convertfrom-json
        if ($results.items -and $results.items.Count -gt 0) {
            $items.AddRange($results.items)
        }
        write-host $results
        # write-host $results.total_pages, $results.total_items
        $Page = $results.page += 1
        while ($Page -le $results.total_pages) {
            $res = search-claim -Channel $Channel -Page $Page
            $items.AddRange($res.items)
            if ($items[-1] -ne $res.items[-1]) {
                write-host $res.items[-1]
            }
            $Page += 1
        }
        return $items
    } else {
        $results = & $lbrynet claim search "--channel=$Channel" --page=$Page | convertfrom-json
        return $results.items
    }
}

function sync-claim {
    param(
        [string] $Url,
        [string] $DownloadDir=""
    )
    $results = & $librarynet get $Url $DownloadDir
}
$res = search-claim -Channel "`@Deterrence-Dispensed"
write-host $res.Count
$cnt = 1
$res | foreach-object {
    write-host $cnt
    if ($_.value.stream_type) {
        write-host $_.value.stream_type
    } else {
        $_|format-list
    }
    $cnt += 1
}
$res = search-claim -Channel "@Ivan's_CAD_Streams"
write-host $res.Count
write-host $res[0]
