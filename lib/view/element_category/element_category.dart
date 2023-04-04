import 'package:flutter/material.dart';
import 'package:rs_libras/controller/categories.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController controller = YoutubePlayerController(
  initialVideoId: '',
  flags: const YoutubePlayerFlags(
    autoPlay: true,
    mute: true,
    hideControls: true,
    loop: true,
    hideThumbnail: true,
  ),
);

class ElementCategory extends StatelessWidget {
  const ElementCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> elementArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final category = categories.firstWhere(
        (category) => category.name == elementArguments['category']);
    final element = category.elements
        .firstWhere((element) => element.id == elementArguments['element']);
    
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: element.url,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(element.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: false,
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (element.id > 0) {
                elementArguments['element'] = element.id - 1;

                Navigator.pushReplacementNamed(
                  context,
                  '/element',
                  arguments: elementArguments,
                );
              }
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 60,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.home),
            iconSize: 60,
          ),
          IconButton(
            onPressed: () {
              if (element.id < category.elements.length - 1) {
                elementArguments['element'] = element.id + 1;

                Navigator.pushReplacementNamed(
                  context,
                  '/element',
                  arguments: elementArguments,
                );
              } else {
                null;
              }
            },
            icon: const Icon(Icons.arrow_forward),
            iconSize: 60,
          ),
        ],
      ),
    );
  }
}
