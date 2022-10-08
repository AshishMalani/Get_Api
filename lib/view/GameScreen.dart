import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Game_Model.dart';
import '../service/Game_Service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selected = 0;
  int x = 0;
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        key: _sliderKey,
        future: GameService.getGame(),
        builder:
            (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: List.generate(
                      snapshot.data!.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                snapshot.data![index].thumbnail.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: 256,
                      aspectRatio: 16 / 9,
                      viewportFraction: 2,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInQuint,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selected = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.white),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon:
                            Icon(Icons.notifications_none, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              selected == index ? Colors.green : Colors.white,
                          radius: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
