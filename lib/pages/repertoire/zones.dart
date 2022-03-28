import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/models/province.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
//import 'package:yebamibekoapp/models/quizz_theme.dart';
//import 'package:yebamibekoapp/widgets/quizz/quiz_options.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ZonesPage extends StatelessWidget {
  final String provinceId;

  const ZonesPage({Key? key, required this.provinceId}) : super(key: key);

  Future<List<Province>> getZonesList(provinceid) async {
    debugPrint('000000000000000000' + provinceid);
    var response = await http.get(Uri.parse(
        'http://app.yebamibeko.org/api/communeprovince/' + provinceid));
    debugPrint(response.body.toString());
    var dataDecoded = json.decode(response.body);
    // debugPrint("2222222" + dataDecoded['result'].toString());

    List<Province> zones_list = [];

    if (response.statusCode == 200) {
      dataDecoded.forEach((theme) {
        //debugPrint("3333333" + theme.toString());

        String nom = theme['ville_nom'];
        if (nom != null) {
          if (nom.length > 25) {
            nom = theme['ville_nom'].substring(1, 25) + "...";
          }
          //String body = theme['article'].replaceAll(RegExp(r'\n'), " ");

          zones_list.add(Province(theme['ville_id'], nom));
        }
        /**/
      });
      //debugPrint("444444" + posts.toString());
      zones_list.sort((Province a, Province b) => a.nom.compareTo(b.nom));
      return zones_list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provinceid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trouver une clinique'),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                  /*decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                      image: Image.asset('assets/images/women_educ.jpg').image,
                      fit: BoxFit.cover),
                ),
                height: 200,*/
                  ),
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Les communes",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0),
                ),
              ),
            ),
            Transform.translate(
                offset:
                    Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
                child: FutureBuilder(
                    future: getZonesList(provinceid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<dynamic> mapdata = snapshot.data as List<dynamic>;
                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 60.0, bottom: 120.0), //.all(0.0),
                            scrollDirection: Axis.vertical,
                            primary: true,
                            itemCount: mapdata.length, //data.length,
                            itemBuilder: (BuildContext content, int index) {
                              return Container(
                                  padding: const EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 0.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, '/centres',
                                          arguments:
                                              mapdata[index].id.toString()),
                                      child: Hero(
                                          tag: mapdata[index].nom,
                                          child: Material(
                                              elevation: 5.0,
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Container(
                                                padding: EdgeInsets.all(16.0),
                                                child: AutoSizeText(
                                                  mapdata[index].nom,
                                                  minFontSize: 18.0,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  wrapWords: false,
                                                ),
                                              )))));
                            });
                      }
                      return const Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
                    })),
            const SizedBox(
              height: 50,
            )
          ],
        ));
  }

  /*_categoryPressed(BuildContext context, QuizzTheme quizzTheme) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(
          quizzTheme: quizzTheme,
        ),
        onClosing: () {},
      ),
    );
  }*/
}
