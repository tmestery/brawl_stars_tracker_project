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