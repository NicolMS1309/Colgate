import 'dart:async';
import 'package:flutter/material.dart';
import 'package:colgate/Pages/SoloVideo.dart';
import 'package:colgate/Pages/bot.dart';
import 'package:colgate/Pages/formato.dart';
import 'package:colgate/Pages/juegos.dart';
import 'package:colgate/Pages/llamada.dart';
import 'package:colgate/Pages/PromoVideoeImagen.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final MediaArguments video;

  const Video({Key? key, required this.video}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _backTime;
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _controller = VideoPlayerController.asset(widget.video.video);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    _controller.setLooping(false);
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0, end: 360.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  get body => Stack(
        children: [
          videoPlayer,
          backButton,
        ],
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

  void stopTimer() {}

  void startTimer() {
    _backTime = Timer(Duration(seconds: 25), () {
      Navigator.of(context).pop();
    });
  }

  FutureBuilder get videoPlayer => FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //_controller.play();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: body,
        floatingActionButton: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  right: 10,
                  bottom: 0,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      IgnorePointer(
                        child: Container(
                          color: Colors.transparent,
                          height: 300.0,
                          width: 300.0,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(270),
                            degOneTranslationAnimation.value * 115),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degOneTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () async {
                                _controller.pause();
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => VideoImagen(
                                            img: MediaArguments(
                                                widget.video.video,
                                                widget.video.promo,
                                                widget.video.bot,
                                                widget.video.juegos,
                                                widget.video.llamada,
                                                widget.video.eleccion,
                                                widget.video.eleccionjuego,
                                                widget.video.eleccionllamada,
                                                widget.video.eleccionbot,
                                                widget.video.name))));
                                _controller.play();
                              },
                              child: Image.asset(
                                'assets/btn_promo.png',
                                width: 150,
                              )),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(225),
                            degTwoTranslationAnimation.value * 110),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degTwoTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              _controller.pause();
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Juegos(
                                          juego: MediaArguments(
                                              widget.video.video,
                                              widget.video.promo,
                                              widget.video.bot,
                                              widget.video.juegos,
                                              widget.video.llamada,
                                              widget.video.eleccion,
                                              widget.video.eleccionjuego,
                                              widget.video.eleccionllamada,
                                              widget.video.eleccionbot,
                                              widget.video.name))));
                              _controller.play();
                            },
                            child: Image.asset(
                              'assets/btn_juegos.png',
                              width: 150,
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(200),
                            degThreeTranslationAnimation.value * 130),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degThreeTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () async {
                                _controller.pause();
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Bott(
                                            bot: MediaArguments(
                                                widget.video.video,
                                                widget.video.promo,
                                                widget.video.bot,
                                                widget.video.juegos,
                                                widget.video.llamada,
                                                widget.video.eleccion,
                                                widget.video.eleccionjuego,
                                                widget.video.eleccionllamada,
                                                widget.video.eleccionbot,
                                                widget.video.name))));
                                _controller.play();
                              },
                              child: Image.asset(
                                'assets/btn_bot.png',
                                width: 150,
                              )),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset.fromDirection(getRadiansFromDegree(180),
                            degThreeTranslationAnimation.value * 150),
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value))
                            ..scale(degThreeTranslationAnimation.value),
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () async {
                                _controller.pause();
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Llamada(
                                            llamda: MediaArguments(
                                                widget.video.video,
                                                widget.video.promo,
                                                widget.video.bot,
                                                widget.video.juegos,
                                                widget.video.llamada,
                                                widget.video.eleccion,
                                                widget.video.eleccionjuego,
                                                widget.video.eleccionllamada,
                                                widget.video.eleccionbot,
                                                widget.video.name))));
                                _controller.play();
                              },
                              child: Image.asset(
                                'assets/btn_llamada.png',
                                width: 150,
                              )),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              if (animationController.isCompleted) {
                                animationController.reverse();
                              } else {
                                animationController.forward();
                              }
                            },
                            child: Image.asset(
                              'assets/boton_click.png',
                              width: 135,
                            )),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
