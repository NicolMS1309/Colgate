import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AsistenteVirtual extends StatefulWidget {
  const AsistenteVirtual({Key? key}) : super(key: key);

  @override
  State<AsistenteVirtual> createState() => _AsistenteVirtualState();
}

class _AsistenteVirtualState extends State<AsistenteVirtual> {

  late Widget contenedor = const Text('Hablando');
  int nivelSpeech = 0;
  

  //Componentes para el SpeechToText
  SpeechToText speechToText = SpeechToText();
  bool _speechEnabled = false;
  String peticion = '';
  String frase = '';
  int ns = 0;

  void _initSpeech() async{
    _speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void _startListening() async{
    
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async{
    setState(() {
      peticion = result.recognizedWords;
      debugPrint('Peticion: $peticion');

      if(!speechToText.isListening){
        _resultadoPeticion(peticion);
      }
    }); 
  }

  void _resultadoPeticion(String p) async{
    switch(nivelSpeech){
      case 1:
      if(p.toLowerCase().contains('recomendaciones')){
        speak(1);
      }
      else{
        speak(404);
      }
      break;

      case 2:
      if(p.toLowerCase().contains('blanqueamiento dental') || p.toLowerCase().contains('blanqueamiento') || p.toLowerCase().contains('dental')){
        speak(2);
      }
      else if(p.toLowerCase().contains('aliento fresco') || p.toLowerCase().contains('aliento') || p.toLowerCase().contains('fresco')){
        speak(3);
      }
      else if(p.toLowerCase().contains('alivio de la sensibilidad') || p.toLowerCase().contains('alivio') || p.toLowerCase().contains('sensibilidad')){
        speak(4);
      }
      else if(p.toLowerCase().contains('regresar')){
        if(ns == 1){
          speak(0);
        }
      }
      else{
        speak(404);
      }
      break;

      case 3:
      if(p.toLowerCase().contains('sí') || p.toLowerCase().contains('claro') || p.toLowerCase().contains('por supuesto') || p.toLowerCase().contains('si')){
        speak(5); 
      }
      else if(p.toLowerCase().contains('no') || p.toLowerCase().contains('ya es todo') || p.toLowerCase().contains('por el momento no')){
        speak(6);
      }
      break; 
    }
  }

  void detenerMicrofono() async {
    speechToText.stop();
  }

  //Componentes para el TextToSpeech
  late FlutterTts flutterTts;

  //Inicializar el TTS - STT
  @override
  void initState() {
    super.initState();

    _initSpeech();

    flutterTts = FlutterTts();

    FutureBuilder(
      future: speak(0),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return contenedor ;
      },
    );
  }

  //Componentes para el TextToSpeech
  speak(int numSpeech) async{
    ns = numSpeech;
    bool microfono = false;
    await flutterTts.setLanguage('es-MX');
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setQueueMode(0);

    switch(numSpeech){
      case 0:
        frase = 'Hola, yo soy el asistente virtual de Colgate. ¿En que te puedo ayudar?';
        contenedor = Column(
          children: [

            Center(
              child: Text(
                frase, 
                style: const TextStyle(
                  fontSize: 30
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                speak(1);
                peticion = '';
              }, 

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 254, 4, 4))
              ),

              child: Column(
                children: const [
                  Image(
                    image: AssetImage('assets/recomendaciones.png'),
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    'Recomendaciones', 
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                  )
                ],
              ) 
            )
          ],
        );

        microfono = true;
        nivelSpeech = 1;
      break;

      case 1:
        frase = 'Perfecto!. Para darte recomendaciones necesito saber, ¿Qué necesidad buscas cubrir?';
        contenedor = Column(
          children: [
            Center(
              child: Text(
                frase,
                style: const TextStyle(
                  fontSize: 30
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    speak(2);
                  }, 

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 17, 0))
                  ),

                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage('assets/blanqueamiento_dental.png'),
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        'Blanqueamiento Dental', 
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ],
                  )
                ),

                ElevatedButton(
                  onPressed: () {
                    peticion = '';
                    speak(3);
                  }, 

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 17, 0))
                  ),

                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage('assets/aliento_fresco.png'),
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        'Aliento Fresco', 
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ],
                  )
                ),

                ElevatedButton(
                  onPressed: () {
                    peticion = '';
                    speak(4);
                  }, 

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 17, 0))
                  ),

                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage('assets/sensivilidad.png'),
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        'Alivio de la Sensibilidad', 
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        )
                      )
                    ],
                  )
                ),

              ],
            )
          ],
        );

        microfono = true;
        nivelSpeech = 2;
      break;

      case 2:
        frase = 'Para el blanqueamiento dental te recomendamos Colgate Luminous White Carbón Activado. ¿Te puedo ayudar en algo más?';
        contenedor = Column(
          children: [
            Center(
              child: Text(
                frase,
                style: const TextStyle(
                  fontSize: 30
                ),
              )
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 255, 0, 0)
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/colgate_luminous_white_carbon_activado.png')
                    ),
                    Text(
                      'Colgate® Luminous White Carbón Activado',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
        microfono = true;
        nivelSpeech = 3;
      break;

      case 3:
        frase = 'Para el aliento fresco te recomendamos Colgate Total Professional Aliento Saludable. ¿Te puedo ayudar en algo más?';
        contenedor = Column(
          children: [
            Center(
              child: Text(
                frase,
                style: const TextStyle(
                  fontSize: 30
                ),
              )
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 255, 0, 0)
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/colgate_luminous_white_carbon_activado.png')
                    ),
                    Text(
                      'Colgate Total Professional Aliento Saludable',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
        microfono = true;
        nivelSpeech = 3;
      break;

      case 4:
        frase = 'Para el alivio de la Sensibilidad te recomendamos Colgate Sensitive Pro-Alivio Inmediato Encías. ¿Te puedo ayudar en algo más?';
        contenedor = Column(
          children: [
            Center(
              child: Text(
                frase,
                style: const TextStyle(
                  fontSize: 30
                ),
              )
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 255, 0, 0)
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/colgate_luminous_white_carbon_activado.png')
                    ),
                    Text(
                      'Colgate Sensitive Pro-Alivio Inmediato Encías',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
        microfono = true;
        nivelSpeech = 3;
      break;

      case 5:
        frase = 'Perfecto!. En qué te puedo ayudar?';
        contenedor = Column(
          children: [

            Center(
              child: Text(
                frase, 
                style: const TextStyle(
                  fontSize: 30
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                speak(1);
                peticion = '';
              }, 

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 254, 4, 4))
              ),

              child: Column(
                children: const [
                  Image(
                    image: AssetImage('assets/recomendaciones.png'),
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    'Recomendaciones', 
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )
                  )
                ],
              ) 
            )
          ],
        );

        microfono = true;
        nivelSpeech = 1;
      break;

      case 6:
        frase = 'No olvides contarnos tu experiencia. Escanea este código que te llevará a nuestra página de Facebook';
        contenedor = const Center(child: Image(image: AssetImage('assets/qr_colgate.png')));
        microfono = false;
      break;

      case 404: 
        frase = 'Esta opción no la reconozco, por favor intenta con otra';
        numSpeech =  numSpeech;
        microfono = true;
      break;
    }

    flutterTts.speak(frase);

    flutterTts.setStartHandler(() {
      setState(() {
        debugPrint('Empece a hablar');
        if(speechToText.isListening){
          detenerMicrofono();
        }
      });
    });


    flutterTts.setCompletionHandler(() {
      setState(() {
        debugPrint('Termine de hablar');
        if(microfono){
        _startListening();
      }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asistente Virtual'),
      ),
      body: contenedor,
    );
  }
}