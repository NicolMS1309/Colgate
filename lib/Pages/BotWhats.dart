import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BotWhats extends StatefulWidget {
  @override
  State<BotWhats> createState() => _BotWhatsState();
}

class _BotWhatsState extends State<BotWhats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }

  Widget get body => Stack(
        children: [PaginaNestle],
      );
  Widget get bot => Container(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/juegos.jpg'),
                fit: BoxFit.fitHeight)),
      ));
  Widget get PaginaNestle => WebviewScaffold(
        url: 'https://www.elmejornido.com/login/',
      );
}
