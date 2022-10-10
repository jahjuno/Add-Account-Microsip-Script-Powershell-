Write-Host "
    **************************************************
    *            AJOUT COMPTE MICROSIP               *
    **************************************************
"

#function to format microsip.ini 
$username = Read-Host -Prompt "Votre Prénom Usuel (sans caractère spéciaux) >>> "

#verification if username starts with capital letter
if ($username -cmatch "^[A-Z]{1}") {
    $username_new = $username
}


#otherwise, capitalize the first letter
else { 
    
    $username_new = $username.Substring(0,1).ToUpper()+$username.Substring(1).ToLower()
}



function Get-IniContent ($FilePath) {

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

$upload_microsip_file = $env:APPDATA   #get userprofil path
$data = Get-IniContent -filePath $upload_microsip_file\MicroSIP\microsip.ini #get microsip file of configuration 


$data.Account1.label = $username_new
$data.Account1.username = $username_new
$data.Account1.authID = $username_new
$data.Account1.displayName = $username_new


$data.Account1