import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yebamibekoapp/models/rubrique.dart';
import 'package:yebamibekoapp/widgets/blog_card.dart';
import 'package:yebamibekoapp/widgets/directory_card.dart';
import 'package:yebamibekoapp/widgets/plainte_card.dart';
import 'package:yebamibekoapp/widgets/service_card.dart';

final List<String> imgList = [
  'assets/images/appslider/1.jpg',
  'assets/images/appslider/2.jpg',
  'assets/images/appslider/3.jpg',
  'assets/images/appslider/4.jpg'
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    const pageTitle = Padding(
      padding: EdgeInsets.only(top: 0, bottom: 10.0),
      child: Text(
        "Bienvenue dans YEBA MIBEKO",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );

    //Auto playing carousel
    final CarouselSlider autoPlayDemo = CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imgList.map(
        (url) {
          return Container(
            margin: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset('assets/images/appslider/1.jpg'),
              /*child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),*/
            ),
          );
        },
      ).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),*/
              autoPlayDemo,
              Container(
                //decoration: new BoxDecoration(color: Colors.yellow),
                padding: const EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    const SizedBox(
                      height: 10.0,
                    ),
                    BlogCard(
                      rubrique: rubriques[1],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ServiceCard(
                      rubrique: rubriques[5],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    PlainteCard(
                      rubrique: rubriques[0],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DirectoryCard(
                      rubrique: rubriques[3],
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
