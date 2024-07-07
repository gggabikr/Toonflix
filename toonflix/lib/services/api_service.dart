import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');

    //this will be the final data from the API
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //it means the request is successful
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
        // var title = webtoon.title;
        // var id = webtoon.id;
        // print('id: $id, title: $title');
      }

      return webtoonInstances; //여기서 함수를 끝낸다.
    }
    throw Error(); //만약 if 부분이 실행되지않으면 에러를 발생시킨다.
  }
}
