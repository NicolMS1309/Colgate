import 'package:flutter/material.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:video_player/video_player.dart';

class Bott extends StatefulWidget {
  final MediaArguments bot;

  const Bott({Key? key, required this.bot}) : super(key: key);

  @override
  State<Bott> createState() => _BottState();
}

class _BottState extends State<Bott> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late MediaArguments video;
  @override
  Widget build(BuildContext context) {
    bool visibilityObs = true;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: <Widget>[
        widget.bot.eleccionbot ? videoPlayer : pictureCarrousel,
        backButton
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
    _controller = VideoPlayerController.asset(widget.bot.bot);
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
                image: AssetImage(widget.bot.bot), fit: BoxFit.fitHeight)),
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
