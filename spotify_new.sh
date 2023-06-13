#Gets access token
TOKEN=$(curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials&client_id=CLIENT_ID&client_secret=CLIENT_SECRET" | jq -r '. | .access_token')
#User Interface to get the artist query
echo -e "Which artist do you want info on: \c"
read NAME
#Name configuration
NAME=$(sed -e 's/ /+/g' <<< "$NAME")
#Gets artist ID
CMD=$(curl --request GET \
  --url "https://api.spotify.com/v1/search?q=$NAME&type=artist&offset=0" \
  --header "Authorization: Bearer $TOKEN" | jq -r '.artists.items[0].id')
#while loop to get the top 10 tracks
i=0
while [ $i -lt 10 ]
do
echo $(curl --request GET \
  --url "https://api.spotify.com/v1/artists/$CMD/top-tracks?market=IN" \
  --header "Authorization: Bearer $TOKEN" | jq ".tracks[$i].name")
i=$((i+1))
done
#code end