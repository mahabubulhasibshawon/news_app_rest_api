import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/news_topics_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'images/category_icon.png',
              height: 30,
              width: 30,
            ),),
        title: Text('News', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,

          )
        ],
      ),
    );
  }
}
