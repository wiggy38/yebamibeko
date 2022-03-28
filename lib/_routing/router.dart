import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yebamibekoapp/_routing/routes.dart';
import 'package:yebamibekoapp/pages/home_page.dart';
import 'package:yebamibekoapp/pages/services/services.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  //AudioCache player = new AudioCache();

  switch (settings.name) {
    case homePageRoute:
      return MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: 'Bienvenue sur Yeba Mibeko'));
    case servicesPageRoute:
      return MaterialPageRoute(builder: (context) => ServicesPage());
    default:
      return MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: 'Bienvenue sur Yeba Mibeko'));
  }
}
