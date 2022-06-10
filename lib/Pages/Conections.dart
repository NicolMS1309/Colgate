import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode_scan2/model/android_options.dart';
import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:colgate/Pages/Secundaria.dart';
import 'package:colgate/Pages/formato.dart';

class Comections extends StatefulWidget {
  final BluetoothDevice server;

  const Comections({Key? key, required this.server}) : super(key: key);

  @override
  State<Comections> createState() => _ComectionsState();
}

class _ComectionsState extends State<Comections> {
  late BluetoothConnection connection;

  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print(widget.server);
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      connection.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
  }

  CarouselController _controller = CarouselController();
  final List<Product> productos = [
    new Product(
        name: 'Pan',
        code: '7501000111800',
        description: 'Pan Tostado',
        imgUrl: 'assets/producto1.png',
        video: 'assets/producto1.mp4',
        promo: 'assets/promo.mp4',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: true,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
    new Product(
        name: 'Principe',
        code: '7503034672111',
        description: 'Principe Fresa',
        imgUrl: 'assets/producto2.png',
        video: 'assets/producto2.mp4',
        promo: 'assets/promo.mp4',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: true,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
    new Product(
        name: 'Donitas',
        code: '7501000106356',
        description: 'Donitas',
        imgUrl: 'assets/producto3.png',
        video: 'assets/producto3.mp4',
        promo: 'assets/promo.mp4',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: true,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
    new Product(
        name: 'Gansito',
        code: '7501000106356',
        description: 'Donitas',
        imgUrl: 'assets/producto4.png',
        video: 'assets/producto4.mp4',
        promo: 'assets/promo.mp4',
        bot: 'assets/bot.png',
        juegos: 'assets/juegos.jpg',
        llamda: 'assets/llamada.mp4',
        eleccion: true,
        eleccionbot: false,
        eleccionjuego: false,
        eleccionllamada: true),
  ];
  Stack get body => Stack(
        children: <Widget>[background, pictureCarrousel, camera],
      );

  Widget get pictureCarrousel => Positioned(
      right: 0,
      child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              carouselController: _controller,
              items: productos
                  .map((e) => ClipRRect(
                        child: Container(
                          color: Colors.transparent,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      selectProduct(e);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      alignment: FractionalOffset.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                            image: AssetImage(e.imgUrl),
                                          )),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Positioned(
            bottom: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => _controller.previousPage(),
              color: Colors.black,
              iconSize: 50,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
              color: Colors.black,
              iconSize: 50,
            ),
          ),
        ],
      ));

  Widget get background => Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xF2B705),
            image: DecorationImage(
                image: AssetImage('assets/principal.jpg'),
                fit: BoxFit.fitHeight),
          ),
        ),
      );

  void selectProduct(Product product) {
    print("----------------------------------");
    print("obj selected: $product");
    print("----------------------------------");
    switch (product.name) {
      case 'Pan':
        sendmensaje('a');
        break;
      case 'Principe':
        sendmensaje('b');
        break;
      case 'Donitas':
        sendmensaje('c');
        break;
      case 'Gansito':
        sendmensaje('d');
        break;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Video(
            video: MediaArguments(
                product.video,
                product.promo,
                product.bot,
                product.juegos,
                product.llamda,
                product.eleccion,
                product.eleccionjuego,
                product.eleccionllamada,
                product.eleccionbot,
                product.name))));
  }

  Widget get camera => Positioned(
        bottom: (MediaQuery.of(context).size.height / 5),
        left: MediaQuery.of(context).size.width / 3.4,
        child: GestureDetector(
          onTap: () {
            startScan(productos);
            //startScan(productos);
          },
          child: Container(
            width: MediaQuery.of(context).size.height / 2.4,
            height: MediaQuery.of(context).size.height / 2,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image:
                    DecorationImage(image: AssetImage('assets/escaner.png'))),
          ),
        ),
      );

  void startScan(List<Product> products) async {
    var options =
        ScanOptions(useCamera: 0, android: AndroidOptions(useAutoFocus: true));
    BarcodeScanner.scan(options: options).then((value) {
      Product product;
      try {
        product = products
            .firstWhere((producto) => producto.code == value.rawContent);
        selectProduct(product);
      } catch (e) {
        print("not valid product, scanned code: " + value.rawContent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: body,
    );
  }

  Future<void> sendmensaje(String Comando) async {
    try {
      connection.output.add(ascii.encode(Comando));
      await connection.output.allSent;
      print('Se mando el comando');
    } catch (e) {
      print(e);
    }
  }
}
