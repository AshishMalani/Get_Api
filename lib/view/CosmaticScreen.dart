import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/CosmaticProduct.dart';
import '../service/cosmatic_prroduct_sevice.dart';

class CosmaticScreen extends StatefulWidget {
  const CosmaticScreen({Key? key}) : super(key: key);

  @override
  State<CosmaticScreen> createState() => _CosmaticScreenState();
}

class _CosmaticScreenState extends State<CosmaticScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: CosmaticService.getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CosmaticProduct>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Row(children: [
                      Icon(Icons.arrow_back_ios),
                      Spacer(),
                      Icon(Icons.shopping_cart),
                    ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Row(children: [
                      Text(
                        "ShopX",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Spacer(),
                      Icon(Icons.list),
                      SizedBox(width: width * 0.05),
                      Icon(Icons.grid_view),
                    ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3.4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return Card(
                          elevation: 15,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Center(
                                      child: Image(
                                        image: NetworkImage(
                                          data.imageLink.toString(),
                                        ),
                                        height: 150,
                                        width: 150,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 105,
                                      child: Like(),
                                    ),
                                  ],
                                ),
                                Text(
                                  data.name.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                data.rating != null
                                    ? Container(
                                        height: height * 0.035,
                                        width: width * 0.15,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: width * 0.005),
                                            Text(
                                              data.rating.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  "\$${data.price.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SpinKitChasingDots(
              duration: Duration(seconds: 2),
              color: Colors.blue,
              size: 50.0,
            );
          }
        },
      ),
    );
  }
}

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: InkWell(
        onDoubleTap: () {
          setState(() {
            isfavorite = !isfavorite;
          });
        },
        child: Icon(
          isfavorite == true ? Icons.favorite : Icons.favorite_border,
          size: 20,
          color: Colors.red,
        ),
      ),
    );
  }
}
