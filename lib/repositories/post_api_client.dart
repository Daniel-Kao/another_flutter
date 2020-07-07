import 'dart:convert';

import 'package:another_flutter/models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostApiClient {
  static const baseUrl = "https://jsonplaceholder.typicode.com/posts";
  final http.Client httpClient;

  PostApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Post>> getPosts(int startIndex, int limit) async {
    final postsUrl = '$baseUrl?_start=$startIndex&_limit=$limit';
    final response = await this.httpClient.get(postsUrl);

    if (response.statusCode != 200) {
      throw Exception(' error getting posts');
    }

    final data = jsonDecode(response.body) as List;
    return data
        .map((rawPost) => Post(
              id: rawPost['id'],
              title: rawPost['title'],
              body: rawPost['body'],
            ))
        .toList();
  }
}
