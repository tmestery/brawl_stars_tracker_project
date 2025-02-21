import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> getGlobalLeaderboard() async {
  const String leaderboardUrl =
      'https://api.brawlstars.com/v1/rankings/global/players';

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
  await getGlobalLeaderboard();
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List<String>> getPlayerRankings() async {
//   const playerTag = '%232LJC99808'; // %23 is URL encoding for '#'
//   const String playerUrl = 'https://api.brawlstars.com/v1/players/$playerTag';

//   Future<Map<String, dynamic>> getJSON(String url) async {
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization':
//               'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjVlOGY5YTAzLTA0ODUtNDQwMC04NDFmLTEwNGM1ZjBkZDFiZCIsImlhdCI6MTczODYzNDE3NSwic3ViIjoiZGV2ZWxvcGVyLzg0ZmVkOWFkLWMzOTQtODVlMy04ZGI1LTYzZTQyOGNiOTE0MCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMTI5LjE4Ni4xOTMuOTYiLCIxMjkuMTg2LjE5My4xMDciXSwidHlwZSI6ImNsaWVudCJ9XX0.-IvxlDdxhhsxDFgROPnouLZSP_1mamFaYaOE_gMDWf6cbM389O0QplbwHsvQngYhPiL-wp83i4z6CZcLWG7Gqw',
//         },
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }

//       return json.decode(response.body);
//     } catch (error) {
//       print('Error fetching data: $error');
//       return {};
//     }
//   }

//   try {
//     Map<String, dynamic> data = await getJSON(playerUrl);
//     print(data);
//     return parseLeaderboard(json.encode(data));
//   } catch (e) {
//     print('Error fetching player rankings: $e');
//     return [];
//   }
// }

// List<String> parseLeaderboard(String responseBody) {
//   try {
//     final Map<String, dynamic> parsedJson = json.decode(responseBody);
//     final List<dynamic> players = parsedJson['items'] ?? [];
//     return players.map<String>((player) => player['name'] as String).toList();
//   } catch (e) {
//     print('Error parsing leaderboard data: $e');
//     return [];
//   }
// }
