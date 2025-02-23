import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> getCurrentEvents() async {
  const String eventsUrl = 'https://api.brawlstars.com/v1/events/rotation';

  Future<Map<String, dynamic>> getJSON(String url) async {
    try {
      await dotenv.load(fileName: ".env");
      String apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $apiKey',
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
    Map<String, dynamic> data = await getJSON(eventsUrl);
    List<String> events = parseEvents(json.encode(data));

    for (var event in events) {
      print(event);
    }

    return events;
  } catch (e) {
    print('Error fetching events: $e');
    return [];
  }
}

List<String> parseEvents(String responseBody) {
  try {
    final Map<String, dynamic> parsedJson = json.decode(responseBody);
    final List<dynamic> eventList = parsedJson['events'] ?? [];

    return eventList.map<String>((event) {
      return '${event['eventMode']} - ${event['map']}';
    }).toList();
  } catch (e) {
    print('Error parsing event data: $e');
    return [];
  }
}

void main() async {
  await getCurrentEvents();
}