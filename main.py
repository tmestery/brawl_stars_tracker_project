import requests

class Main:
    def __init__(self):
        file = open("api_key.txt", "r")
        API_KEY = file.read().strip()
        file.close()  # Manually closing the file

        PLAYER_TAG = "28UY8YJY0"
        url = f"https://api.brawlstars.com/v1/players/%23{PLAYER_TAG}"
        headers = {"Authorization": f"Bearer {API_KEY}"}

        response = requests.get(url, headers=headers)
        data = response.json()

        self.finalCopy = data.get("trophies", "No trophy data found")

# Example usage:
player = Main()
print(player.finalCopy)  # Prints the trophy count