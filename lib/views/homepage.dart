import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/models/generalmodel.dart';
import 'package:news_api/models/newschannelheadlines.dart';
import 'package:news_api/view/news_view.dart';
import 'package:news_api/views/categories.dart';
import 'package:news_api/views/detail_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum filterlist { bbcnews, aryNews, cnn, independent, alJazeera, espn }

class _HomepageState extends State<Homepage> {
  final format = DateFormat("MMMM dd, yyyy");
  NewsView newsView = NewsView();
  filterlist? selectednews;
  String name = "bbc-news";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()));
              },
              icon: Image.asset(
                "images/category_icon.png",
                height: 30,
                width: 30,
              )),
          title: const Center(
              child: Text(
            "News",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          )),
          actions: [
            PopupMenuButton<filterlist>(
                initialValue: selectednews,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (filterlist item) {
                  if (filterlist.bbcnews.name == item.name) {
                    name = "bbc-news";
                  }
                  if (filterlist.alJazeera.name == item.name) {
                    name = "al-jazeera-english";
                  }
                  if (filterlist.aryNews.name == item.name) {
                    name = "ary-news";
                  }
                  if (filterlist.cnn.name == item.name) {
                    name = "cnn";
                  }
                  if (filterlist.independent.name == item.name) {
                    name = "independent";
                  }
                  if (filterlist.espn.name == item.name) {
                    name = "espn";
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<filterlist>>[
                      const PopupMenuItem<filterlist>(
                          value: filterlist.bbcnews, child: Text("BBC News")),
                      const PopupMenuItem<filterlist>(
                          value: filterlist.alJazeera,
                          child: Text("AlJazeera News")),
                      const PopupMenuItem<filterlist>(
                          value: filterlist.aryNews, child: Text("ARY News")),
                      const PopupMenuItem<filterlist>(
                          value: filterlist.cnn, child: Text("CNN News")),
                      const PopupMenuItem<filterlist>(
                          value: filterlist.independent,
                          child: Text("Independents News")),
                      const PopupMenuItem<filterlist>(
                          value: filterlist.espn, child: Text("ESPN News")),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<newsmodel>(
                  future: newsView.fetchNewsReposity(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          author: snapshot.data!.articles![index].author
                                              .toString(),
                                          content: snapshot.data!.articles![index].content
                                              .toString(),
                                          description: snapshot.data!
                                              .articles![index].description
                                              .toString(),
                                          newdatetime: snapshot.data!
                                              .articles![index].publishedAt
                                              .toString(),
                                          newimage: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          source: snapshot.data!
                                              .articles![index].source!.name
                                              .toString(),
                                          title: snapshot.data!.articles![index].title.toString())));
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.6,
                                      width: width * 0.9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(21),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            child: spinkit2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.bottomCenter,
                                          height: height * .22,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: width * 0.7,
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
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                        format.format(dateTime))
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
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),

            //general portion
            Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<generalcategory>(
                  future: newsView.fetchgeneralcategory("General"),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(21),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: width * .3,
                                    height: height * .18,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    placeholder: (context, url) => Container(
                                      child: const Center(
                                        child: SpinKitCircle(
                                          size: 50,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: height * .18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 3,
                                        stepGranularity: 1,
                                        maxFontSize: 15,
                                        minFontSize: 12,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 1,
                                            stepGranularity: 1,
                                            maxFontSize: 12,
                                            minFontSize: 9,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          AutoSizeText(
                                            format.format(dateTime),
                                            maxLines: 1,
                                            stepGranularity: 1,
                                            maxFontSize: 10,
                                            minFontSize: 7,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);
