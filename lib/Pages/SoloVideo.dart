import 'dart:async';
import 'package:flutter/material.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:video_player/video_player.dart';

class SoloVideo extends StatefulWidget {
  final MediaArguments video;

  const SoloVideo({Key? key, required this.video}) : super(key: key);
  @override
  State<SoloVideo> createState() => _SoloVideoState();
}

class _SoloVideoState extends State<SoloVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _backTime;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video.llamada);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  FutureBuilder get videoPlayer => FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // _controller.play();
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
  void stopTimer() {
    if (_backTime != null) {
      _backTime.cancel();
      _backTime = 0 as Timer;
    }
  }

  Widget get body => Stack(
        children: [
          videoPlayer,
          backButton,
        ],
      );

  void startTimer() {
    _backTime = Timer(Duration(seconds: 15), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: body,
    );
  }
}
