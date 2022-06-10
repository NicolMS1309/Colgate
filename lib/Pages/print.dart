import 'dart:io';
import 'package:colgate/Pages/Conections.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:colgate/Pages/testprint.dart';
import 'package:path_provider/path_provider.dart';

class Print extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final MediaArguments print;
  Print(this.data, this.print);
  @override
  _PrintState createState() => _PrintState();
}

class _PrintState extends State<Print> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final Nombre = TextEditingController();
  final Email = TextEditingController();
  final Number = TextEditingController();

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  late bool _connected;
  String? nom, pathImage3;
  TestPrint? testPrint;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initSavetoPath3();
    // initSavetoPath4();
    // initSavetoPath5();
    // initSavetoPath6(); //logo producto3
    testPrint = TestPrint();
  }

  initSavetoPath3() async {
    final filename = 'logo_ticket.jpg';
    var bytes = await rootBundle.load("assets/logo_ticket.jpg");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    setState(() {
      pathImage3 = '$dir/$filename';
    });
  }

  // initSavetoPath4() async {
  //   final filename = 'cepillarse1.png';
  //   var bytes = await rootBundle.load("assets/cepillarse1.png");
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   writeToFile(bytes, '$dir/$filename');
  //   setState(() {
  //     pathImageC4 = '$dir/$filename';
  //   });
  // }

  // // CREAR IMAGEN
  // initSavetoPath5() async {
  //   final filename = 'cepillarse2.png';
  //   var bytes = await rootBundle.load("assets/cepillarse2.png");
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   writeToFile(bytes, '$dir/$filename');
  //   setState(() {
  //     pathImageC5 = '$dir/$filename';
  //   });
  // }

  // initSavetoPath6() async {
  //   final filename = 'cepillarse3.png';
  //   var bytes = await rootBundle.load("assets/cepillarse3.png");
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   writeToFile(bytes, '$dir/$filename');
  //   setState(() {
  //     pathImageC6 = '$dir/$filename';
  //   });
  // }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registrate para imprimir'),
          backgroundColor: Color.fromARGB(255, 48, 17, 254),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: Nombre,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nombre',
                      hintText: '',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: Email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Correo Electronico',
                      hintText: '',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: Number,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Numero telefonico',
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 100.0, right: 100.0, top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 48, 17, 254)),
                    onPressed: () async {
                      if ((await bluetooth.isConnected)!) {
                        nom = Nombre.text;
                        var name = widget.print.name;
                        switch (name) {
                          // case 'Nescafe':
                          //   //producto1
                          //   testPrint!.sample(pathImage!, nom);
                          //   Navigator.pushNamed(context, 'home');
                          //   break;
                          // case 'Nan':
                          //   //producto2
                          //   testPrint!.sample2(pathImage2!, nom);
                          //   Navigator.pushNamed(context, 'home');
                          //   break;
                          // case 'Lechera':
                          //   //producto3
                          //   testPrint!.sample3(pathImage3!, nom);
                          //   Navigator.pushNamed(context, 'home');
                          //   break;
                          default:
                            testPrint!.sample4(pathImage3!, nom);
                        }
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Imprimir promo',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('salir'),
          icon: Icon(Icons.arrow_back),
          backgroundColor: Color.fromARGB(187, 30, 0, 255),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name ?? ''),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
