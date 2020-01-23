import 'package:flutter/material.dart';

import 'got.dart';

class episodespage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage image;

  episodespage({this.episodes, this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Hero(
              tag: "g1",
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/9/92/Game_of_Thrones_Season_7.png'),
              ),
            ),
            Text("All episodes"),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: episodes.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {},
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  episodes[index].image.original,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        episodes[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${episodes[index].season}-${episodes[index].number}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
