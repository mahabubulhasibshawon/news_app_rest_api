import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:news_app/widgets/news_topics_widget.dart';

import '../models/categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList {bbcNews, bbcSports, independent, reuters, cnn, alJazeera  }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd, yy');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        actions: [
          PopupMenuButton(
              initialValue: selectedMenu,
              icon: Icon(Icons.more_vert),
              onSelected: (FilterList item){
                if(FilterList.bbcNews.name == item.name){name = 'bbc-news';}
                if(FilterList.bbcSports.name == item.name){name = 'bbc-sport';}
                if(FilterList.independent.name == item.name){name = 'independent';}
                if(FilterList.reuters.name == item.name){name = 'reuters';}
                if(FilterList.cnn.name == item.name){name = 'cnn';}
                if(FilterList.alJazeera.name == item.name){name = 'al-jazeera-english';}
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context)=> <PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(value: FilterList.bbcNews,child: Text('BBC News')),
            PopupMenuItem<FilterList>(value: FilterList.bbcSports,child: Text('BBC Sports')),
            PopupMenuItem<FilterList>(value: FilterList.independent,child: Text('Independent')),
            PopupMenuItem<FilterList>(value: FilterList.reuters,child: Text('Reuters')),
            PopupMenuItem<FilterList>(value: FilterList.cnn,child: Text('CNN')),
            PopupMenuItem<FilterList>(value: FilterList.alJazeera,child: Text('Al Jazera')),
              ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .28,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * .5,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(child: spinKit2),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 33,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height * .1,
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * .7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder: (context, url) =>
                                        Container(child: spinKit2),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                                Expanded(child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot
                                          .data!.articles![index].title
                                          .toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,fontWeight: FontWeight.w700
                                        ),),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // source
                                          Text(snapshot
                                              .data!.articles![index].source!.name
                                              .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.blueAccent,fontWeight: FontWeight.w500
                                            ),),
                                          // date & time
                                          Text(format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black54,fontWeight: FontWeight.w500
                                            ),)
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
