TOKEN=$(curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials&client_id=a07a807ea6bc47499ab66177cd36e371&client_secret=b232e2a7da4c4bc79e6cb38a15877b1c" | jq -r '. | .access_token')

ARTIST=$(curl "https://api.spotify.com/v1/artists/4Z8W4fKeB5YxbusRsdQVPb" \
     -H "Authorization: Bearer $TOKEN" | jq -r '.images[0].url')

touch download.jpeg
curl -o download.jpeg $ARTIST
