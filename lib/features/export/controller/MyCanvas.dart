import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class AddressPainter extends CustomPainter{

  dynamic generateImage() async {

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(2000, 2000)));

    canvas.drawImageRect(image!, Rect.fromCircle(center: ui.Offset(1000, 1000), radius: 1000),Rect.fromCenter(center: ui.Offset(250, 250), width: 500, height: 500), Paint());

    final textStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: 13.75,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
        fontWeight : ui.FontWeight.bold

    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('Balkiraz Mahallesi, Tıp Fakültesi Caddesi, No: 79/D-E, Mamak/Ankara');
    final constraints = ui.ParagraphConstraints(width: 200);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    final offset = Offset(150, 350);
    canvas.drawParagraph(paragraph, offset);


    final picture = recorder.endRecording();
    final img = await picture.toImage(200, 200);
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer;

  }

  // static final AddressPainter instance = AddressPainter();
  //
  // AddressPainter() {
  //   _loadImage(cachedImageFileMyCanvas!).then((value){this.image= value;});
  // }
  //
  // File? cachedImageFileMyCanvas;
  ui.Image? image;





  @override
  void paint(Canvas canvas, Size size) async {


    canvas.drawImageRect(image!, Rect.fromCircle(center: ui.Offset(1000, 1000), radius: 1000),Rect.fromCenter(center: ui.Offset(250, 250), width: 500, height: 500), Paint());

    final textStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,

    );
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText('Balkiraz Mahallesi, Tıp Fakültesi Caddesi, No: 79/D-E, Mamak/Ankara');
    final constraints = ui.ParagraphConstraints(width: 200);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(constraints);
    final offset = Offset(100, 350);
    canvas.drawParagraph(paragraph, offset);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) { })

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    throw UnimplementedError();
  }


}