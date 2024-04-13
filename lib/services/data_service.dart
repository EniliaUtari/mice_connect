import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mice_connect/dto/news.dart';
import 'package:mice_connect/endpoints/endpoints.dart';

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

static Future<void> editNews(String id, String title, String body) async {
  final response = await http.put(
    Uri.parse('${Endpoints.news}/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'body': body,
    }),
  );

  if (response.statusCode == 200) {
    // Check for edit success (200 OK)
    print('News with id: $id edited successfully');
  } else {
    // Handle error
    throw Exception('Failed to edit news with id: $id');
  }
}


  static Future<void> deleteNews(String id) async {
  final response = await http.delete(
    Uri.parse('${Endpoints.news}/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // Check for deletion success (200 OK)
    print('News with id: $id deleted successfully');
  } else {
    // Handle error
    throw Exception('Failed to delete news with id: $id');
  }
}

}