import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> getCurrentEvents() async {
  const String eventsUrl = 'https://api.brawlstars.com/v1/events/rotation';

  Future<dynamic> getJSON(String url) async {
    await dotenv.load(fileName: ".env");
    String apiKey = dotenv.env['API_KEY'] ?? '';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  dynamic data = await getJSON(eventsUrl);
  if (data is List) {
    return parseEvents(data);
  }
  return [];
}

List<String> parseEvents(List<dynamic> eventList) {
  return eventList.map<String>((event) {
    String mode = event['event']['mode'] ?? 'Unknown Mode';
    String map = event['event']['map'] ?? 'Unknown Map';
    return '$mode - $map';
  }).toList();
}

void main() async {
  await getCurrentEvents();
}