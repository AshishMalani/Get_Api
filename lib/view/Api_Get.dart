import 'dart:convert';

import 'package:api_get/model/product_model.dart';
import 'package:api_get/service/api_service.dart';
import 'package:api_get/view/Search_Bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Loiie.dart';

class ApiGet extends StatefulWidget {
  const ApiGet({Key? key}) : super(key: key);

  @override
  State<ApiGet> createState() => _ApiGetState();
}

class _ApiGetState extends State<ApiGet> {
  List? productList;
  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'),
    );
    setState(() {
      productList = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchBar(productList!));
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: FutureBuilder(
          future: ApiService.getProducts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final products = snapshot.data![index];
                  return ListTile(
                    title: Text(
                      snapshot.data![index].title.toString(),
                      maxLines: 1,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        products.image.toString(),
                      ),
                    ),
                    subtitle: Text(
                      products.price.toString(),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Lotte(),
              );
            }
          },
        ));
  }
}
