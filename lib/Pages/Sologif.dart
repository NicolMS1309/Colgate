import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:colgate/Pages/BotWhats.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:colgate/Pages/print.dart';
import 'package:colgate/Pages/testprint.dart';

class Gif extends StatefulWidget {
  final MediaArguments gif;

  const Gif({Key? key, required this.gif}) : super(key: key);
  @override
  State<Gif> createState() => _GifState();
}

class _GifState extends State<Gif> {
  String? pathImage;
  TestPrint? testPrint;
  final List<Map<String, dynamic>> data = [
    {
      'title': 'Produk 1',
      'price': 10000,
      'qty': 2,
      'total_price': 20000,
    },
    {
      'title': 'Produk 2',
      'price': 20000,
      'qty': 2,
      'total_price': 40000,
    },
    {
      'title': 'Produk 3',
      'price': 12000,
      'qty': 1,
      'total_price': 12000,
    },
  ];

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Widget get body => Stack(
        children: [pictureCarrousel, backButton, buttonim, llamdaBot],
      );
  Widget get pictureCarrousel => Container(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.gif.promo), fit: BoxFit.fitHeight)),
      ));

  Widget get backButton => Positioned(
        bottom: 10.0,
        left: 10.0,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Salir'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
  Widget get llamdaBot => Positioned(
      bottom: 400,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'botWhats');
        },
        child: Image.asset(
          'assets/btnbot.png',
          width: 145,
        ),
      ));

  Widget get buttonim => Positioned(
      bottom: 250,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Print(
                      data,
                      MediaArguments(
                          widget.gif.video,
                          widget.gif.promo,
                          widget.gif.bot,
                          widget.gif.juegos,
                          widget.gif.llamada,
                          widget.gif.eleccion,
                          widget.gif.eleccionjuego,
                          widget.gif.eleccionllamada,
                          widget.gif.eleccionbot,
                          widget.gif.name))));
        },
        child: Image.asset(
          'assets/btnimp.png',
          width: 145,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}
