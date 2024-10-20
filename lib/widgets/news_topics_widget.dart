import 'package:flutter/material.dart';

class NewsTopicsWidget extends StatelessWidget {
  final List<String> newsStoryImages;
  const NewsTopicsWidget({super.key, required this.newsStoryImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
          itemCount: newsStoryImages.length,
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(newsStoryImages[index]),
          ),
        );
      }),
    );
  }
}
