import 'dart:math';

import 'package:yebamibekoapp/models/appel.dart';
import 'package:yebamibekoapp/resources/post_db_provider.dart';
import 'package:yebamibekoapp/widgets/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:yebamibekoapp/pages/blog/post.dart';
import 'package:http/http.dart' as http;
import 'package:yebamibekoapp/widgets/post_items_list.dart';
import 'dart:async';
import 'dart:convert';

var COLORS = [
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.lightGreen,
  Colors.yellowAccent,
  Colors.deepPurple
];

class BlogPage extends StatefulWidget {
  BlogPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<Post>> showPosts() async {
    //debugPrint('000000000000000000');
    try {
      var response = await http
          .get(Uri.parse('https://www.mwinda-rdc.org/mobileapi/blog/posts'));
      //debugPrint("11111111111");
      var dataDecoded = json.decode(response.body);
      //debugPrint("2222222" + dataDecoded.toString());
      //List<Post> posts = List();

      if (response.statusCode == 200) {
        dataDecoded.forEach((post) {
          debugPrint("3333333" + post.toString());
          /*String title = post['title'];
          if(title.length>25){
            title = post['title']; //.substring(1,25) + "...";
          }
          String body = post['article'].replaceAll(RegExp(r'\n'), " ");
          if (post['image'] != null) {
            if(post['image'].contains('images') ) {
              posts.add(Post(int.parse(post['id']), title, post['category'], body, post['image']));
            }
          } */
          var article = Post(
              id: int.parse(post['id']),
              title: post['title'],
              category: post['category'],
              text: post['article'],
              image: post['image']);
          PostDatabaseProvider.db.addPostToDatabase(article);
        });
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Echec du chargement des articles');
      }
    } catch (e) {
      debugPrint(e.toString());
      //Future<List<Post>> posts = PostDatabaseProvider.db.getAllPosts();
      //return posts;
    }

    Future<List<Post>> posts = PostDatabaseProvider.db.getAllPosts();
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    /*Person jane = Person(
        id: 1,
        name: "Jane",
        city: "Ouaga",
      );
      PersonDatabaseProvider.db.addPersonToDatabase(jane);

      Person john = Person(
        id: 1,
        name: "John",
        city: "Bobo",
      );
      PersonDatabaseProvider.db.addPersonToDatabase(john);*/

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Transform.translate(
              offset: Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
              //MediaQuery.of(context).size.height * 0.1050),

              /*child: FutureBuilder<List<Post>>(
        future: showPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Post item = snapshot.data[index];
                return Container(
                  
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.category),
                    leading: CircleAvatar(child: Text(item.id.toString())),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),*/

              child: FutureBuilder(
                  future: showPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var values = (snapshot.data as List<Appel>).toList();
                      /*return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 0.0, bottom: 60.0), //.all(0.0),
                        scrollDirection: Axis.vertical,
                        primary: true,
                        itemCount: values.length, //data.length,
                        itemBuilder: (BuildContext content, int index) {
                          return AwesomeListItem(
                              id: snapshot.data[index].id,
                              title: snapshot.data[index].title,
                              category: snapshot.data[index].category,
                              content:
                                  'Lorem Ipsum', //snapshot.data[index]["content"],
                              //color: Colors.lightGreen![100], //[index]["color"],
                              image: snapshot.data[index].image);
                        },
                      );*/
                      return Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                            CircularProgressIndicator()
                          ]));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                      /*return Align(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  );*/
                    } else {
                      return const Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                    // By default, show a loading spinner.
                  })),
          Transform.translate(
            offset: const Offset(0.0, -56.0),
            child: Container(
              child: ClipPath(
                clipper: MyClipper(),
                child: Stack(
                  children: [
                    Image.asset('assets/images/rubriq_actualites.jpg',
                        fit: BoxFit.fill),
                    Opacity(
                      opacity: 0.2,
                      child: Container(color: COLORS[0]),
                    ),
                    // Title on main baner
                    Transform.translate(
                      offset: const Offset(0.0, 50.0),
                      child: const ListTile(
                        /*leading: CircleAvatar(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4"),
                              ),
                            ),
                          ),
                        ),*/
                        title: Text(
                          "Tous les articles",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        /*subtitle: Text(
                          "Lead Designer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0),
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
