import os
import requests

file = open("api_key.txt","r")
API_KEY = file.read()
print(API_KEY)
PLAYER_TAG = "28UY8YJY0"


url = f"https://api.brawlstars.com/v1/players/%23{PLAYER_TAG}"
headers = {"Authorization": f"Bearer {API_KEY}"}


response = requests.get(url,headers)
data = response.json()
print(data["trophies"])