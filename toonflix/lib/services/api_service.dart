import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  List<WebtoonModel> webtoonInstances = [];
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //it means the request is successful
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        // var title = toon.title;
        // var id = toon.id;
        // print('id: $id, title: $title');
      }

      return webtoonInstances; //여기서 함수를 끝낸다.
    }
    throw Error(); //만약 if 부분이 실행되지않으면 에러를 발생시킨다.
  }
}
