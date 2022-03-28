import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

export 'package:flutter_map/src/core/point.dart';
export 'package:flutter_map/src/geo/crs/crs.dart';
export 'package:flutter_map/src/geo/latlng_bounds.dart';
export 'package:flutter_map/src/layer/circle_layer.dart';
export 'package:flutter_map/src/layer/group_layer.dart';
export 'package:flutter_map/src/layer/layer.dart';
export 'package:flutter_map/src/layer/marker_layer.dart';
export 'package:flutter_map/src/layer/overlay_image_layer.dart';
export 'package:flutter_map/src/layer/polygon_layer.dart';
export 'package:flutter_map/src/layer/polyline_layer.dart';
export 'package:flutter_map/src/layer/tile_layer.dart';
export 'package:flutter_map/src/layer/tile_provider/tile_provider.dart';
//export 'package:flutter_map/src/layer/tile_provider/mbtiles_image_provider.dart';
export 'package:flutter_map/src/plugins/plugin.dart';
import 'package:yebamibekoapp/models/centre.dart';

class MapScreen extends StatelessWidget {
  // Declare a field that holds the Post.
  //final Centre centre;

  // In the constructor, require a Post.
  MapScreen({Key? key}) : super(key: key);

  Image getImage() {
    AssetImage assetImage = const AssetImage("assets/images/mapbox-icon.png");
    Image image = Image(image: assetImage);
    return image;
  }

  Widget build(BuildContext context) {
    final centre = ModalRoute.of(context)!.settings.arguments as Centre;
    var lat = double.parse(centre.latitude);
    var long = double.parse(centre.longitude);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            centre.nom,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(lat, long),
              zoom: 16.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/appyebamibeko/cl16thylp000314s7c02dbxiq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXBweWViYW1pYmVrbyIsImEiOiJja2syajhmenUxMXI1Mnhycms4enc1MXAzIn0.O2zm3qGI0M7rKq1l7f1fvg",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiYXBweWViYW1pYmVrbyIsImEiOiJja2syamFubjExMW80Mm9wY212Y3FhZjN4In0.GF-D2sQiouSaZ5cGULVcJg',
                  'id': 'mapbox.mapbox-streets-v8',
                },
                attributionBuilder: (_) {
                  return const Text("© OpenStreetMap contributors");
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(lat, long),
                    builder: (ctx) => Container(
                      child: getImage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  double boxesWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
