import 'dart:math';

import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:yebamibekoapp/utils/utils.dart';
import 'package:yebamibekoapp/pages/blog/post.dart';
import 'package:http/http.dart' as http;
//import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AwesomeListItem extends StatefulWidget {
  int id;
  String title;
  String category;
  String content;
  Color color;
  String image;

  AwesomeListItem(
      {required this.id,
      required this.title,
      required this.category,
      required this.content,
      required this.color,
      required this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    //debugPrint('IIIID ' + widget.id.toString());
    return Container(
      margin:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0, bottom: 2.0),
      color: Colors.lightBlue[100],
      child: Row(
        children: <Widget>[
          Container(
            width: 5.0,
            height: 190.0,
            color: Colors.lightBlue,
          ),
          Expanded(
              child: InkWell(
            onTap: () => Navigator.pushNamed(context, singlePostPageRoute,
                arguments: widget.id.toString()),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      widget.category,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
          // Contient l'image d'un item de la liste'
          Container(
            height: 150.0,
            width: 150.0,
            color: Colors.lightBlue[100],
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(50.0, -10.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: widget.color,
                    ),
                  ),
                ),
                //if (widget.image.contains('images')) {
                Transform.translate(
                  offset: const Offset(10.0, 0.0),
                  //child: Card(
                  //elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    /*child: Image.network(
                              widget.image,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.fitHeight,
                          ),*/
                  ),
                  //),
                ),
                /*} else {
                  Transform.translate(
                    offset: Offset(10.0, 0.0),
                    //child: Card(
                      //elevation: 10.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                              color: Colors.lightBlue[100],
                              image: DecorationImage(
                                image: AssetImage(AvailableImages.rubriqActualites['assetPath']),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                      ),
                    //),
                  ),
                }*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
