import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:colgate/Pages/Conections.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:flutter/services.dart';
import 'package:colgate/Pages/tiraled.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final List<Product> productos = [
    new Product(
        name: 'Kacang',
        code: '',
        description: 'Producto Kacang',
        imgUrl: 'assets/nescafe.png',
        video: 'assets/producto1.mp4',
        promo: 'assets/ofertacafe.gif',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: false,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
    new Product(
        name: 'Sabritas',
        code: '',
        description: 'Producto Sabritas',
        imgUrl: 'assets/lechera.png',
        video: 'assets/producto2.mp4',
        promo: 'assets/lechera.gif',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: false,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
    new Product(
        name: 'Rufles',
        code: '',
        description: 'Producto Rufles',
        imgUrl: 'assets/nan.png',
        video: 'assets/producto4.mp4',
        promo: 'assets/nan.gif',
        bot: 'assets/botPower.jpg',
        juegos: 'assets/juegosPower.jpg',
        llamda: 'assets/llamadaPower.mp4',
        eleccion: true,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true)
  ];
  Stack get body => Stack(
        children: <Widget>[button],
      );

  Widget get PaginaNestle => WebviewScaffold(
        url: 'https://www.elmejornido.com/login/',
      );
  Widget get button => Positioned(
        //bottom: 500.0,
        //left: 600,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final BluetoothDevice selectedDevice =
                await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SelectBondedDevicePage(checkAvailability: false);
                },
              ),
            );
            if (selectedDevice != null) {
              print('Connect -> selected ' + selectedDevice.address);
              _startChat(context, selectedDevice);
            } else {
              print('Connect -> no device selected');
            }
          },
          icon: Icon(Icons.start_outlined),
          label: Text('Iniciar'),
          backgroundColor: Color.fromARGB(255, 14, 14, 241),
        ),
      );
  Widget get background => Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xF2B705),
            image: DecorationImage(
                image: AssetImage('assets/principal.jpg'),
                fit: BoxFit.fitHeight),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: body,
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Comections(server: server);
        },
      ),
    );
  }
}
