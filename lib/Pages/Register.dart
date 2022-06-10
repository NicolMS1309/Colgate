import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            'https://www.chedraui.com.mx/Departamentos/c/MC?q=%3arelevance%3abrand%3aColgate&siteName=Sitio+de+Chedraui&isAlcoholRestricted=false',
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
    );
  }
}
