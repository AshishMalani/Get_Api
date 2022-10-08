import 'package:flutter/material.dart';

import 'DitelsScreen.dart';

class SearchBar extends SearchDelegate {
  List list;

  SearchBar(this.list);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      list[index]['imageLink'].toString(),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? list
        : list
            .where((element) => element['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(suggestionList[index]['image_link'].toString()),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DitelsScreen(
                      image: suggestionList[index]['image_link'].toString(),
                      name: suggestionList[index]['name'].toString()),
                ));
          },
          title: Text(suggestionList[index]['name'].toString()),
        );
      },
    );
  }
}
