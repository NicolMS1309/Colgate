class Product {
  String imgUrl;
  String description;
  String name;
  String code;
  String video;
  String promo;
  String bot;
  String juegos;
  String llamda;
  bool eleccion;
  bool eleccionjuego;
  bool eleccionllamada;
  bool eleccionbot;

  Product(
      {required this.imgUrl,
      required this.video,
      required this.description,
      required this.name,
      required this.code,
      required this.promo,
      required this.bot,
      required this.juegos,
      required this.llamda,
      required this.eleccion,
      required this.eleccionbot,
      required this.eleccionjuego,
      required this.eleccionllamada});
  @override
  String toString() {
    return "Product: name: $name, image: $imgUrl video: $video description: $description code: $code promo:$promo bot:$bot juegos:$juegos llamda:$llamda eleccion:$eleccion eleccionbot:$eleccionbot eleccionllamda:$eleccionllamada eleccionjuego:$eleccionjuego";
  }
}

class MediaArguments {
  final String video;
  final String promo;
  final String bot;
  final String juegos;
  final String llamada;
  final bool eleccion;
  final bool eleccionjuego;
  final bool eleccionllamada;
  final bool eleccionbot;
  final String name;

  MediaArguments(
      this.video,
      this.promo,
      this.bot,
      this.juegos,
      this.llamada,
      this.eleccion,
      this.eleccionjuego,
      this.eleccionllamada,
      this.eleccionbot,
      this.name);
}
