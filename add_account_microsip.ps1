Write-Host "
    **************************************************
    *            AJOUT COMPTE MICROSIP               *
    **************************************************
"

#function to format microsip.ini 

function Get-IniContent ($filePath) {

    $initial_value = @{}

    switch -regex -file $FilePath {

        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $initial_value[$section] = @{}
            $CommentCount = 0
        }


        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $initial_value[$section][$name] = $value
        }


        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $initial_value[$section][$name] = $value
        }
    }
    return $initial_value

}

$upload_microsip_file = 'Your Microsip.ini PATH'
$data = Get-IniContent -filePath $upload_microsip_file

#Information needed to modify during add account
$data['Account3']['label']
$data['Account3']['Server']
$data['Account3']['domain']
$data['Account3']['username']
$data['Account3']['authID']
$data['Account3']['displayName'] 

