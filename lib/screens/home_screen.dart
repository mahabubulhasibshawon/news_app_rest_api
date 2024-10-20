import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_topics_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          NewsTopicsWidget(newsStoryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVNVhyEwYufQjhE49rjKod_J23Cxw5IJgdtQ&s',
            'https://media.istockphoto.com/id/929047972/vector/world-news-flat-vector-icon-news-symbol-logo-illustration-business-concept-simple-flat.jpg?s=612x612&w=0&k=20&c=5jpcJ7xejjFa2qKCzeOXKJGeUl7KZi9qoojZj1Kq_po=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlV29TLa-ZmcwVA1vuj4zQvhIMt0oxgmCw1Q&s',
            'https://ygo-assets-entities-emea.yougov.net/ca73e0f7-c574-11e8-8d12-4b6fc186e574.jpg',
            'https://cdn0.iconfinder.com/data/icons/circle-icons/512/cnn.png',
            'https://static.vecteezy.com/system/resources/previews/010/994/369/non_2x/la-liga-logo-symbol-design-spain-football-european-countries-football-teams-illustration-free-vector.jpg',
            'https://c8.alamy.com/comp/C4YNDY/champions-league-uefa-logo-flag-symbol-icon-C4YNDY.jpg',
            'https://banner2.cleanpng.com/20180626/sxk/aazvdh5yb.webp',
            'https://seeklogo.com/images/P/premier-league-new-logo-D22A0CE87E-seeklogo.com.png',
            'https://banner2.cleanpng.com/20180711/vg/aawnpno4v.webp',
            'https://dorve.com/wp-content/uploads/2023/08/overlap-premier-league-logo.png',
          ],),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Trending'),
              SizedBox(width: 5),
              Text('Trending'),
              SizedBox(width: 5),
              Text('Trending'),
              SizedBox(width: 5),
              Text('Trending'),
              SizedBox(width: 5),
            ],
          ),
        ],
      ),

    );
  }
}
