// Define the API URL
const KEY = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjVlOGY5YTAzLTA0ODUtNDQwMC04NDFmLTEwNGM1ZjBkZDFiZCIsImlhdCI6MTczODYzNDE3NSwic3ViIjoiZGV2ZWxvcGVyLzg0ZmVkOWFkLWMzOTQtODVlMy04ZGI1LTYzZTQyOGNiOTE0MCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMTI5LjE4Ni4xOTMuOTYiLCIxMjkuMTg2LjE5My4xMDciXSwidHlwZSI6ImNsaWVudCJ9XX0.-IvxlDdxhhsxDFgROPnouLZSP_1mamFaYaOE_gMDWf6cbM389O0QplbwHsvQngYhPiL-wp83i4z6CZcLWG7Gqw';
const PLAYER_TAG = "28UY8YJY0"
const COUNTRY_CODE = "global"
const apiUrl = 'https://api.brawlstars.com/v1/rankings/global/clubs';
var authorization = {"Authorization": "Bearer "+KEY};


get()

async function get() {
    // Make a GET request
    const response = await fetch(apiUrl, {
        method: "GET",
        headers: authorization,
    });
    console.log(response)
}
