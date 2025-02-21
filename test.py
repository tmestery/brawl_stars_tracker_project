import os
import requests

file = open("/Users/tmestery/brawl_tracker/apiKey.txt","r")
API_KEY = file.read()
PLAYER_TAG = "28UY8YJY0"
COUNTRY_CODE = "global"

player_rankings_url = f"https://api.brawlstars.com/v1/rankings/{COUNTRY_CODE}/players"
club_rankings_url = f"https://api.brawlstars.com/v1/rankings/{COUNTRY_CODE}/clubs"
events_url = "https://api.brawlstars.com/v1/events/rotation"
headers = {"Authorization": f"Bearer {API_KEY}"}


player_rankings_data = (requests.get(player_rankings_url,headers)).json()
club_rankings_data = (requests.get(club_rankings_url,headers)).json()
events_data = (requests.get(events_url,headers)).json()

print("GLOBAL PLAYER LEADERBOARDS")
for i in player_rankings_data["items"]:
    name = i["name"]
    trophies = i["trophies"]
    s = f"{name:<24}{trophies}"
    print(s)

print("\nGLOBAL CLUB LEADERBOARDS")
for i in club_rankings_data["items"]:
    name = i["name"]
    trophies = i["trophies"]
    s = f"{name:<24}{trophies}"
    print(s)