import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qreaderapp/src/bloc/scans_bloc.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  String tipoMapa = 'dark';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        //print(tipoMapa);
        switch (tipoMapa) {
          case 'streets': tipoMapa = 'dark';            
            break;
          case 'dark': tipoMapa = 'light';            
            break;
          case 'light': tipoMapa = 'outdoors';            
            break;
          case 'outdoors': tipoMapa = 'satellite';            
            break;
          default: tipoMapa = 'streets';
            break;
        }

        setState((){});
      }
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
        'id': 'mapbox.$tipoMapa'
        //tipos de mapas: streets, dark, light, outdoors, satellite
        }
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 60,
              color: Theme.of(context).primaryColor
            ),
          ),
        )
      ]
    );
  }


  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
       
      ],
    );
  }
}