import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:MICEconnect/dto/news.dart';
import 'package:MICEconnect/endpoints/endpoints.dart';

class DataService{
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      // Handle error
      throw Exception('Failed to load news');
    }
  }

  // post data to endpoint news
  static Future<News> createNews(String title, String body) async {
    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      // Check for creation success (201 Created)
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      // Handle error
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }
  static Future<void> postEvent(String title, String body) async {
    Map<String, String> input = {
      "title": title,
      "body": body,
    };
    String dataJson = jsonEncode(input);
    await http.post(
      Uri.parse(Endpoints.news),
      body: dataJson,
      headers: {
        'Content-Type': 'application/json',
      },
    );
}
}