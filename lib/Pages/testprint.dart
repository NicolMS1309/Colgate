import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(String pathImage, Nombre) async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(Nombre + " " + "difruta de esta receta", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("CAFE PAN DE MUERTO", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('INGREDIENTES:', 2, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom('2 cucharadas de NESCAFE CLASICO', 1, 0);
        bluetooth.printCustom('1 1/2 tazas de agua caliente', 1, 0);
        bluetooth.printCustom('1/4 de cucharadita de esencia de azahar', 1, 0);
        bluetooth.printCustom(
            '1/4 de cucharadita de mantequilla fundida', 1, 0);
        bluetooth.printCustom(
            '1/4 de taza de COFFEE MATE Líquido Sabor Vainilla', 1, 0);
        bluetooth.printCustom('1 Pan de muerto', 1, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Obten tu regalo escaneando el QR", 2, 1);
        bluetooth.printQRcode(
            "https://www.nescafe.com/mx/recetas/nescafer-cafe-pan-de-muerto",
            200,
            200,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  sample3(String pathImage, Nombre) async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(Nombre + " " + "difruta de esta receta", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("ROLLITOS CRUJIENTES DE PLATANO", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('INGREDIENTES:', 2, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom('6 Tortillas de harina calientes', 1, 0);
        bluetooth.printCustom('1 Taza de Nuez picada', 1, 0);
        bluetooth.printCustom('2.5 Platanos cortados en rodajas', 1, 0);
        bluetooth.printCustom('Aceite de maiz para freir', 1, 0);
        bluetooth.printCustom(
            '1 Envase de Leche Condensada LA LECHERA Untable', 1, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Obten tu regalo escaneando el QR", 2, 1);
        bluetooth.printQRcode(
            "https://www.recetasnestle.com.mx/recetas/rollitos-crujientes-de-platano-2",
            200,
            200,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  sample2(String pathImage, Nombre) async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(Nombre + " " + "difruta de esta receta", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("YORGUTH CON PUFFS", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom('INGREDIENTES:', 2, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom('Yogurt Yogolino', 1, 0);
        bluetooth.printCustom('Puffs Gerber', 1, 0);
        bluetooth.printCustom('Fruta picada', 1, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Obten tu regalo escaneando el QR", 2, 1);
        bluetooth.printQRcode(
            "https://www.nestlebabyandme.com.mx/1-a-3/recetas-yogurth-con-puffs",
            200,
            200,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  sample4(String pathImage, Nombre) async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Hola " + Nombre, 2, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("Este es el modo correcto de cepillarse", 2, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'Limpie las superficies externas de los dientes superiores y luego las de los dientes inferiores',
            1,
            0);
        bluetooth.printNewLine();
        bluetooth.printCustom('Limpie las superficies de masticacion', 1, 0);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'Para tener un aliento mas fresco, no olvide cepillarse tambien la lengua',
            1,
            0);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'Para mas informacion escanea el codigo QR', 1, 0);
        bluetooth.printQRcode(
            "https://www.colgate.com/es-mx/oral-health/brushing-and-flossing/how-to-brush",
            // "https://api.whatsapp.com/send?phone=5215513950319&text=Canjea%20aqui%20tus%20promociones!",
            200,
            200,
            1); //LIGA A DONDE CREAR EL QR
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}

class Testcolor {
  late BluetoothConnection connection;
  sendmensaje() async {
    print('ejecutandose');
    try {
      connection.output.add(ascii.encode('c'));
      await connection.output.allSent;
      print('Se mando el comando');
    } catch (e) {
      print(e);
    }
  }
}
