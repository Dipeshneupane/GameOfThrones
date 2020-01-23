import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:got/episodes.dart';
import 'got.dart';

void main() => runApp(my_app());

class my_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GOT got;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    var res = await http.get(
        "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes");

    var decodeRes = jsonDecode(res.body);

    got = GOT.fromJson(decodeRes);
    print(decodeRes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Of Thrones'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
      body: got == null
          ? Center(child: CircularProgressIndicator())
          : Card(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                      tag: "g1",
                      child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(got.image.original),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      got.name,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      "runtime: " + got.runtime.toString() + " minutes",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      got.summary,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "All Episodes",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => episodespage(
                                      episodes: got.eEmbedded.episodes,
                                      image: got.image,
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
