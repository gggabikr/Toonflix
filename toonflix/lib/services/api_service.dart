import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = "today";

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //it means the request is successful
      print(response.body);
      return; //여기서 함수를 끝낸다.
    }
    throw Error(); //만약 if 부분이 실행되지않으면 에러를 발생시킨다.
  }
}
