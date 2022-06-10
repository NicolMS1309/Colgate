import 'package:flutter/material.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:colgate/Pages/print.dart';
import 'package:video_player/video_player.dart';

class VideoImagen extends StatefulWidget {
  final MediaArguments img;

  const VideoImagen({Key? key, required this.img}) : super(key: key);
  @override
  State<VideoImagen> createState() => _VideoImagenState();
}

class _VideoImagenState extends State<VideoImagen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late MediaArguments video;
  @override
  Widget build(BuildContext context) {
    bool visibilityObs = true;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: <Widget>[
        widget.img.eleccion ? videoPlayer : pictureCarrousel,
        backButton,
        buttonoferta,
        buttonoferta2,
      ]),
    );
  }

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

  Widget get body => Stack(
        children: [
          pictureCarrousel,
          backButton,
          buttonoferta2,
        ],
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.img.promo);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.setLooping(false);
    super.initState();
  }

  FutureBuilder get videoPlayer => FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  Widget get pictureCarrousel => Expanded(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.img.promo), fit: BoxFit.fitHeight)),
      ));

  //ME QUEDE AQUI MODIFICANDO

  Widget get scannerQR => Positioned(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.img.promo), fit: BoxFit.fitHeight)),
      ));

  Widget get buttonoferta => Positioned(
      bottom: 400,
      left: 0,
      child: GestureDetector(
        onTap: () async {
          _controller.pause();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Print(
                      data,
                      MediaArguments(
                          widget.img.video,
                          widget.img.promo,
                          widget.img.bot,
                          widget.img.juegos,
                          widget.img.llamada,
                          widget.img.eleccion,
                          widget.img.eleccionjuego,
                          widget.img.eleccionllamada,
                          widget.img.eleccionbot,
                          widget.img.name))));
          _controller.play();
        },
        child: Image.asset(
          'assets/btnimp.png',
          width: 135,
        ),
      ));

  Widget get buttonoferta2 => Positioned(
      bottom: 250,
      left: 0,
      child: GestureDetector(
        onTap: () async {
          _controller.pause();
          await Navigator.pushNamed(context, 'Registro');
          _controller.play();
        },
        child: Image.asset(
          'assets/btnescaner.png',
          width: 135,
        ),
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
          backgroundColor: Color.fromARGB(187, 30, 0, 255),
        ),
      );
}
