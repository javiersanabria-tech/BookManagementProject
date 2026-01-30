$uri = "https://github.com/soulcurrymedia/twitter-emotion-recognition/blob/master/models/allowed-chars.pkl"

$output = ".\allowed-chars.pkl"

Invoke-WebRequest -Uri $uri -outfile $output