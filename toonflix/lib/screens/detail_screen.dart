import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;
  bool isReadMore = false;

  DetailScreen(
      {super.key,
      required this.title,
      required this.thumb,
      required this.id,
      this.isReadMore = false});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //홈스크린과 달리 아래처럼 할수는 없다. 왜냐하면 이 웹툰과 id가 같은 시점에 초기화되기때문에
  // Future<WebtoonDetailModel> webtoon = ApiService.getToonById(widget.id);

  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  //initState는 항상 build 보다 먼저 실행되고, 한번만 실행된다는걸 우리는 알기때문에
  //이렇게 웹툰과 에피소드의 데이터를 여기서 초기화 해준다는 방법을 사용할 수 있다.
  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 3,
        shadowColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(7, 7),
                              color: Color.fromRGBO(0, 0, 0, 0.4))
                        ],
                      ),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          'Referer': 'https://comic.naver.com',
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '작품소개: ${snapshot.data!.about}',
                          style: const TextStyle(fontSize: 16),
                          maxLines: widget.isReadMore ? 30 : 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(6),
                          child: GestureDetector(
                            child: Text(
                              widget.isReadMore ? "Read less" : "Read more",
                              style: const TextStyle(
                                  color: Color.fromRGBO(14, 24, 208, 1),
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              setState(() {
                                widget.isReadMore = !widget.isReadMore;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '장르: ${snapshot.data!.genre}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData == true) {
                    //많은 데이터를 다루고, 최적화가 필요할때는 ListView나 ListViewBuilder를
                    //사용하는게 좋지만, 지금은 고작해야 10~20개정도의 데이터만 다룰 예정이기때문에
                    //그냥 Column을 사용할 것. 차후에 연습삼아 바꿔보자!
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        108, 244, 128, 0.7)),
                                color:
                                    const Color.fromRGBO(108, 244, 128, 0.294)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(episode.title),
                                  const Icon(Icons.arrow_right_outlined)
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
