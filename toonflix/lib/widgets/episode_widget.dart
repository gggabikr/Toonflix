import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
  });

  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    final url = Uri.parse("https://google.ca");
    await launchUrl(url);
    //혹은 아래처럼 해도 된다.
    // await launchUrlString('https://google.ca');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color.fromRGBO(144, 247, 159, 0.7)),
          color: Colors.green.shade500,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(2, 2),
              color: Color.fromRGBO(0, 0, 0, 0.2),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 200,
            child: Text(
              episode.title,
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_right_outlined)
        ]),
      ),
    );
  }
}
