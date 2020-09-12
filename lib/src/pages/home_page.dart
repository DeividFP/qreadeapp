import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qreaderapp/src/bloc/scans_bloc.dart';

import 'package:qreaderapp/src/pages/direcciones_page.dart';
import 'package:qreaderapp/src/pages/mapas_page.dart';

import 'package:barcode_scan/platform_wrapper.dart';
import 'package:qreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIdex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: scansBloc.borrarScanTODO,
          )
        ],
      ),
      body: _callPage(currentIdex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),  
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIdex,
      onTap: (index) {
        setState(() {
          currentIdex = index;
        });
      },   
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')        
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')        
        )
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch(paginaActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }

  _scanQR(BuildContext context) async {

    //http://google.com
    //geo:40.689879098597345,-74.2517603917969

    dynamic futureString = 'https://www.google.com';
    // try{
    //   futureString = await BarcodeScanner.scan();
    // }catch(e){
    //   futureString = e.toString();
    // }

    if(futureString != null){
      
      final scan = ScanModel(valor: futureString);
      //DBProvider.db.nuevoScan(scan);
      scansBloc.agregarScan(scan);

      final scan2 = ScanModel(valor: 'geo:40.689879098597345,-74.2517603917969');
      scansBloc.agregarScan(scan2);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750), (){
          utils.abrirScan(context, scan);
        });
      }else{
        utils.abrirScan(context, scan);
      }

    }
  }
}