import 'package:colgate/Pages/Conections.dart';
import 'package:flutter/material.dart';
import 'package:colgate/Pages/BotWhats.dart';
import 'package:colgate/Pages/pages/index.dart';
import 'package:colgate/Pages/tiraled.dart';
import 'Pages/ConnectPrint.dart';
import 'Pages/Principal.dart';
import 'Pages/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: ConnectPrint(),
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (context) => ConnectPrint(),
        'botWhats': (context) => BotWhats(),
        'blue': (context) => SelectBondedDevicePage(checkAvailability: false),
        'llamada': (context) => IndexPage(),
        'Registro': (context) => Register(),
      },
    );
  }
}
