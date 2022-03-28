import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
//import 'package:basic_utils/basic_utils.dart';
import 'package:yebamibekoapp/models/centre.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:yebamibekoapp/pages/plaintes/add_appel.dart';

class CentreDetailsPage extends StatelessWidget {
  final Centre centre;

  const CentreDetailsPage({Key? key, required this.centre}) : super(key: key);

  /*Future<Post> fetchPost() async {
    //debugPrint('000000000000000000');
    var response =
        await http.get('https://www.mwinda-rdc.org/mobileapi/blog/posts/120');
    //debugPrint("11111111111");
    var post = json.decode(response.body);
    //debugPrint("2222222" + dataDecoded.toString());

    if (response.statusCode == 200) {
      debugPrint("444444" + post.toString());
      return new Post(int.parse(post['id']), post['title'], post['category'],
          post['article'], post['image']);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final centre = ModalRoute.of(context)!.settings.arguments as Centre;
    debugPrint('000000000000000000' + centre.toString());
    //final User user = users.singleWhere((user) => user.id == 120);
    //debugPrint('THEID ' + this.centre.adresse);
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final cancelBtn = Positioned(
      top: 50.0,
      left: 20.0,
      child: Container(
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: IconButton(
          icon: const Icon(LineIcons.doorClosed, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          iconSize: 20.0,
        ),
      ),
    );

    final userImage = Stack(
      children: <Widget>[
        Hero(
          tag: const AssetImage('assets/images/rubriq_centres.jpg'),
          child: Container(
            height: 50.0,
            width: deviceWidth,
            /*decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rubriq_centres.jpg'),
                fit: BoxFit.cover,
              ),
            ),*/
          ),
        ),
        cancelBtn
      ],
    );

    final hobbies = Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: deviceWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          constraints: const BoxConstraints(minHeight: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "", //"HOBBIES",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Display Post image
        Stack(
          children: <Widget>[
            Hero(
              tag: const AssetImage('assets/images/rubriq_chat.jpg'),
              child: Container(
                height: 250.0,
                width: deviceWidth,
                child: Image.asset('assets/images/rubriq_centres.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            cancelBtn
          ],
        ),
        // Display post title
        Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    centre.nom,
                    //StringUtils.capitalize(centre.nom), //user.name,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                /*Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  height: 30.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      gradient: chatBubbleGradient,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          LineIcons
                              .mars, //user.gender == 'M' ? LineIcons.mars : LineIcons.venus,
                          color: Colors.white,
                        ),
                        Text(
                          '28', //user.age.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ),
                )*/
              ],
            )),
        // Display post category
        Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: const Text(
            'Centre Juridique', //'this.centre.type',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue, //Colors.grey.withOpacity(0.8),
            ),
          ),
        ),
        // Display Post content
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(12.0),
            shadowColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: deviceWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              constraints: const BoxConstraints(minHeight: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Appartenance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  const Text(
                    'Public', //StringUtils.capitalize(this.centre.appartenance),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const Text(
                    "Adresse",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  _buildInfoDisplay(
                      'AV/KASA VUBU Kinshasa'), //this.centre.adresse
                  const Text(
                    "Contact",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  _buildInfoDisplay(centre.phone), //this.centre.phone,
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Offre",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    centre.offre,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  _buildMapButton(centre, context, deviceWidth),
                  _buildAppelButton(centre, context, deviceWidth),
                  _buildPhoneCallButton(centre.phone, context, deviceWidth)
                ],
              ),
            ),
          ),
        ),
        //hobbies
      ],
    )));
  }

  Widget _buildInfoDisplay(data) {
    var display = (data != null) ? data : "- - - ";

    return Text(
      display,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildMapButton(centre, context, deviceWidth) {
    if ((this.centre.latitude != null) && (this.centre.longitude != null)) {
      return Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        padding: const EdgeInsets.only(top: 20.0, bottom: 00.0),
        width: deviceWidth,
        child: ElevatedButton(
          //padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          //color: Colors.lightBlue,
          onPressed: () =>
              Navigator.pushNamed(context, '/centremap', arguments: centre),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              //new Icon(Icons.map, color: Colors.white),
              Text(
                'Afficher la localisation',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 30.0),
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        width: deviceWidth,
        child: const Text(
          'Localisaion bientôt disponible',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ));
  }

  Widget _buildAppelButton(centre, context, deviceWidth) {
    if ((this.centre.latitude != null) && (this.centre.longitude != null)) {
      return Container(
        margin: const EdgeInsets.only(top: 0.0, bottom: 00.0),
        padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
        //constraints: BoxConstraints(maxWidth: 150.0),
        width: deviceWidth,
        child: ElevatedButton(
          //padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          //color: Colors.lightBlue,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAppelPage()),
          ),
          /*Navigator.pushNamed(context, addAppelRoute,
              arguments: this.centre.id),*/
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              //new Icon(Icons.map, color: Colors.white),
              Text(
                'Enregistrer une plainte',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: const Text("Les coordonnées ne peuvent être nulles."),
      );
    }
  }

  Widget _buildPhoneCallButton(centre, context, deviceWidth) {
    if ((this.centre.latitude != null) && (this.centre.longitude != null)) {
      return Container(
        margin: const EdgeInsets.only(top: 0.0, bottom: 30.0),
        padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
        //constraints: BoxConstraints(maxWidth: 150.0),
        width: deviceWidth,
        child: ElevatedButton(
          //padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          //color: Colors.lightBlue,
          onPressed: () => launch("tel://" + this.centre.phone),
          //arguments: this.centre.id),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              //new Icon(Icons.map, color: Colors.white),
              Text(
                'Appeler ce centre',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: const Text("Les coordonnées ne peuvent être nulles."),
      );
    }
  }
}
