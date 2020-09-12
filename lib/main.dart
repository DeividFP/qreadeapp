import 'package:flutter/material.dart';
import 'package:qreaderapp/src/pages/home_page.dart';
import 'package:qreaderapp/src/pages/mapa_pages.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapa': (BuildContext context) => MapaPage(),
      }, 
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}