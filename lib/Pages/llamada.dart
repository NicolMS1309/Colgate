import 'package:flutter/material.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:video_player/video_player.dart';

class Llamada extends StatefulWidget {
  final MediaArguments llamda;

  const Llamada({Key? key, required this.llamda}) : super(key: key);

  @override
  State<Llamada> createState() => _LlamadaState();
}

class _LlamadaState extends State<Llamada> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late MediaArguments video;
  @override
  Widget build(BuildContext context) {
    bool visibilityObs = true;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: <Widget>[
        widget.llamda.eleccionllamada ? videoPlayer : pictureCarrousel,
        backButton,
      ]),
    );
  }

  Widget get body => Stack(
        children: [
          pictureCarrousel,
          backButton,
        ],
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.llamda.llamada);
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
                image: AssetImage(widget.llamda.llamada),
                fit: BoxFit.fitHeight)),
      ));

  Widget get backButton => Positioned(
        bottom: 10.0,
        left: 10.0,
        child: FloatingActionButton.extended(
          heroTag: 'llamada2',
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Salir'),
          backgroundColor: Color.fromARGB(187, 30, 0, 255),
        ),
      );
}
