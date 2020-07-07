import 'dart:convert';

import 'package:another_flutter/models/post.dart';
import 'package:another_flutter/models/result_data.dart';
import 'package:another_flutter/requests/data_helper.dart';
import 'package:another_flutter/requests/http_manager.dart';

import 'apis.dart';

class PostRepository {
  static Future<List<Post>> getPosts(int startIndex, int limit) async {
    // return postApiClient.getPosts(startIndex, limit);
    var params = DataHelper.getBaseMap();
    params.clear();

    params["_start"] = startIndex;
    params["_limit"] = limit;

    final res = await HttpManager.getInstance().get(Apis.posts, params);
    final data = jsonDecode(res) as List;

    print(data);

    return data
        .map((rawPost) => Post(
              id: rawPost['id'],
              title: rawPost['title'],
              body: rawPost['body'],
            ))
        .toList();
  }
}
