$uri = "https://github.com/javiersanabria-tech/BookManagementProject/blob/main/name.Lua"

$output = ".\allowed-chars.pkl"

Invoke-WebRequest -Uri $uri -outfile $output