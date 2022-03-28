import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yebamibekoapp/models/centre.dart';
//import 'package:yebamibeko_app/pages/repertoire/centre_map_direction.dart';

class centreMapPage extends StatelessWidget {
  // Declare a field that holds the Post.
  final Centre centre;

  // In the constructor, require a Post.
  centreMapPage({Key? key, required this.centre}) : super(key: key);

  Image getImage() {
    AssetImage assetImage = AssetImage("images/mapbox-icon.png");
    Image image = Image(image: assetImage);
    return image;
  }

  Widget build(BuildContext context) {
    var lat = double.parse(centre.latitude);
    var long = double.parse(centre.longitude);
    debugPrint(lat.toString() + ' - ' + long.toString());
    return Scaffold(
        appBar: AppBar(title: Text(centre.nom)),
        body: FlutterMap(
            options: MapOptions(center: LatLng(lat, long), minZoom: 15.0),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/rajayogan/cjl1bndoi2na42sp2pfh2483p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXBwbXdpbmRhIiwiYSI6ImNrMTJ6ZW0wbzAzdTgzb29hbXczcGkwazkifQ.wzgSA1yZHNWjiMBMpEur3g",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoiYXBweWViYW1pYmVrbyIsImEiOiJja2syamFubjExMW80Mm9wY212Y3FhZjN4In0.GF-D2sQiouSaZ5cGULVcJg',
                    'id': 'mapbox.mapbox-streets-v7'
                  }),
              MarkerLayerOptions(markers: [
                Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(lat, long),
                    builder: (context) => Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.blue,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        ))
              ])
            ]));
  }

  double boxesWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /*Widget _buildMapButton(centre, context, deviceWidth) {
    if ((centre.latitude != null) && (centre.longitude != null)) {
      return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        width: deviceWidth,
        child: new RaisedButton(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          color: Colors.lightBlue,
          onPressed: () => Navigator.pushNamed(context, centreMapDirectionPage,
              arguments: this.centre),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(Icons.map, color: Colors.white),
              new Text(
                'Afficher la localisation',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
  }*/
}
