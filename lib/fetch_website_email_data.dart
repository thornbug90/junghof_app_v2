import 'dart:convert';

import 'package:http/http.dart' as http;

class Fetched {
  final int sender;
  final int title;
  final String content;

  const Fetched({
    required this.sender,
    required this.content,
    required this.title,
  });

  factory Fetched.fromJson(Map<String, dynamic> json) {
    return Fetched(
      sender: json['sender'],
      content: json['content'],
      title: json['title'],
    );
  }
}

Future<Fetched> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Fetched.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load content');
  }
}
