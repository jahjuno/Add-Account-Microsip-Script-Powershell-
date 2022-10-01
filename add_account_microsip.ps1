Write-Host "
    **************************************************
    *            AJOUT COMPTE MICROSIP               *
    **************************************************
"


function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

# the data returned is a Hashtable where each entry is listed 
# under a certain section name. This data is UNORDERED by default
$data = Get-IniContent -filePath 'C:\Users\OTM_ADMIN\AppData\Roaming\MicroSIP\microsip.ini'

#$data['Account1'].Keys | ForEach-Object { $data['Account1']['server']}
$data['Account1']['label']
$data['Account1']['Server']
$data['Account1']['domain']
$data['Account1']['username']
$data['Account1']['authID']