#!/usr/bin/python3
import os
import requests
import json

file = open("api_key.txt","r")
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
globalPlayerLeaderboardList = []

def main():
    print(player_rankings_data)  # Check the structure of the data
    for i in player_rankings_data["items"]:
        name = i["name"]
        trophies = i["trophies"]
        s = f"{name:<24}{trophies}"
        globalPlayerLeaderboardList.append(s)

if __name__ == "__main__":
    main()
    jsonString = (json.dumps(globalPlayerLeaderboardList))  # Output JSON for Dart
    print(jsonString)

# import os
# import requests
# import json

# # Read API key
# try:
#     with open("api_key.txt", "r") as file:
#         API_KEY = file.read().strip()
# except FileNotFoundError:
#     print(json.dumps({"error": "api_key.txt not found"}))
#     exit(1)

# # Define API URLs
# PLAYER_TAG = "28UY8YJY0"
# COUNTRY_CODE = "global"

# player_rankings_url = f"https://api.brawlstars.com/v1/rankings/{COUNTRY_CODE}/players"
# club_rankings_url = f"https://api.brawlstars.com/v1/rankings/{COUNTRY_CODE}/clubs"
# events_url = "https://api.brawlstars.com/v1/events/rotation"
# headers = {"Authorization": f"Bearer {API_KEY}"}

# # Initialize global leaderboard list
# globalPlayerLeaderboardList = []

# def main():
#     try:
#         # Fetch player rankings
#         player_rankings_response = requests.get(player_rankings_url, headers=headers)
        
#         # Check for response errors
#         if player_rankings_response.status_code != 200:
#             print(json.dumps({"error": f"Failed to fetch player rankings: {player_rankings_response.status_code}"}))
#             exit(1)
        
#         player_rankings_data = player_rankings_response.json()
        
#         for item in player_rankings_data.get("items", []):
#             name = item["name"]
#             trophies = item["trophies"]
#             leaderboard_entry = {"name": name, "trophies": trophies}
#             globalPlayerLeaderboardList.append(leaderboard_entry)
        
#         # Output only valid JSON
#         print(json.dumps(globalPlayerLeaderboardList))

#     except Exception as e:
#         # Output error as JSON
#         print(json.dumps({"error": str(e)}))
#         exit(1)

# if __name__ == "__main__":
#     main()