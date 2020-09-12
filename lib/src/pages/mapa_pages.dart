import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qreaderapp/src/bloc/scans_bloc.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){},
          )
        ],
      ),
      body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        // center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa()
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
        'id': 'mapbox.streets'
        }
    );
  }
}