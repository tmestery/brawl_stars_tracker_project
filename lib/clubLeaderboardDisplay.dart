import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> getGlobalClubLeaderboard() async {
  const String leaderboardUrl =
      'https://api.brawlstars.com/v1/rankings/global/clubs';

  Future<Map<String, dynamic>> getJSON(String url) async {
    try {
      // Importing my api_key.txt document and transferring it into a varibale
      await dotenv.load(fileName: ".env"); // Absolute path
      String apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer $apiKey',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load data: ${response.statusCode}');
      }

      return json.decode(response.body);
    } catch (error) {
      print('Error fetching data: $error');
      return {};
    }
  }

  try {
    Map<String, dynamic> data = await getJSON(leaderboardUrl);
    
    List<String> leaderboard = parseLeaderboard(json.encode(data));
    
    // Print leaderboard
    for (var player in leaderboard) {
      print(player);
    }
    
    return leaderboard;
  } catch (e) {
    print('Error fetching leaderboard: $e');
    return [];
  }
}

List<String> parseLeaderboard(String responseBody) {
  try {
    final Map<String, dynamic> parsedJson = json.decode(responseBody);
    final List<dynamic> players = parsedJson['items'] ?? [];

    return players.map<String>((player) {
      return '#${player['rank']} - ${player['name']} (${player['trophies']} trophies)';
    }).toList();
  } catch (e) {
    print('Error parsing leaderboard data: $e');
    return [];
  }
}

void main() async {
  await getGlobalClubLeaderboard();
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Future<List<String>> getGlobalClubLeaderboard(String selectedCountry) async {
//   // Mapping countries to their respective leaderboard URLs
//   Map<String, String> countryUrls = {
//     'Global': 'https://api.brawlstars.com/v1/rankings/global/clubs',
//     'United States of America': 'https://api.brawlstars.com/v1/rankings/us/clubs',
//     'United Kingdom': 'https://api.brawlstars.com/v1/rankings/gb/clubs',
//     'Germany': 'https://api.brawlstars.com/v1/rankings/de/clubs',
//     'France': 'https://api.brawlstars.com/v1/rankings/fr/clubs',
//     'Japan': 'https://api.brawlstars.com/v1/rankings/jp/clubs',
//   };

//   String url = countryUrls[selectedCountry] ?? countryUrls['Global']!; // Default to Global if country not found

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);

//     // Assuming the data has a list of clubs. Modify this depending on the actual response format
//     List<String> leaderboardClubs = [];
//     for (var club in data['clubs']) {
//       leaderboardClubs.add(club['name']);  // Adjust according to your API response
//     }
//     return leaderboardClubs;
//   } else {
//     throw Exception('Failed to load leaderboard');
//   }
// }

// Future<Map<String, dynamic>> getJSON(String url) async {
//   // Importing my api_key.txt document and transferring it into a variable
//   await dotenv.load(fileName: ".env"); // Absolute path
//   String apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';

//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $apiKey',
//     },
//   );

//   if (response.statusCode != 200) {
//     throw Exception('Failed to load data: ${response.statusCode}');
//   }

//   return json.decode(response.body);
// }

// // Remove the unnecessary try-catch block here
// List<String> parseLeaderboard(String responseBody) {
//   try {
//     final Map<String, dynamic> parsedJson = json.decode(responseBody);
//     final List<dynamic> players = parsedJson['items'] ?? [];

//     return players.map<String>((player) {
//       return '#${player['rank']} - ${player['name']} (${player['trophies']} trophies)';
//     }).toList();
//   } catch (e) {
//     print('Error parsing leaderboard data: $e');
//     return [];
//   }
// }

// void main() async {
//   // Provide a selected country when calling the function
//   String selectedCountry = 'Global';  // You can change this to test with other countries
//   List<String> leaderboard = await getGlobalClubLeaderboard(selectedCountry);

//   // Print leaderboard to check the results
//   for (var player in leaderboard) {
//     print(player);
//   }
// }