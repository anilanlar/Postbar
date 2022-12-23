import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:postbar/core/base/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/home/index.dart';
import 'package:postbar/model/index.dart';
import 'package:postbar/ui/widgets/custom_widgets/index.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme/colors.dart';
import 'MyCanvas.dart';

class ExportController
    extends BaseController<Map<Design, ScreenshotController>> {
  ExportController();

  String exportTest = "exptest";
  File? cachedImageFile;
  File? generatedImageFile;

  RxBool cachedImageFileListener = false.obs;

  // AddressPainter? addressPainter;
  ui.Image? image;
  ByteBuffer? generatedImage;

  HomeController homeController = Get.find<HomeController>();

  void _cacheChosenDesign() async {
    final String? chosenDesignURL = homeController.chosenDesignURL;
    if (chosenDesignURL != null) {
      final Uri url = Uri.parse(Get.find<HomeController>().chosenDesignURL!);
      final http.Response response = await http.get(url);
      final Uint8List bytes = response.bodyBytes;
      final Directory temp = await getTemporaryDirectory();
      final String path = '${temp.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      cachedImageFile = File(path);
      final data = await cachedImageFile!.readAsBytes();
      image = await decodeImageFromList(data);
      generatedImage = await generateImage();
      final Directory tempForGenerated = await getTemporaryDirectory();
      final String pathForGenerated = '${tempForGenerated.path}/image.jpg';
      File(pathForGenerated).writeAsBytesSync(generatedImage!.asUint8List());
      generatedImageFile = File(pathForGenerated);

      cachedImageFileListener.value = !cachedImageFileListener.value;
    } else {
      debugPrint("chosenDesignURL is null");
    }
  }

  Future<ByteBuffer> generateImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final String _title = homeController.vkUser!.title!;
    String franchiseAddress = homeController.vkUser!.franchiseAddress!;
    String franchisePhone = homeController.vkUser!.franchisePhone!;
    franchiseAddress = "${franchiseAddress.replaceAll(",", "\n")}\n";

    if (homeController.isPostorStory.value == "Post") {
      canvas.drawImageRect(
          image!,
          Rect.fromCircle(center: ui.Offset(1000, 1000), radius: 1000),
          Rect.fromCenter(
              center: ui.Offset(1000, 1000), width: 2000, height: 2000),
          Paint());

      final addressTextStyle = ui.TextStyle(
        fontFamily: "VisbyCF",
        color: Colors.white,
        fontWeight: ui.FontWeight.w400,
        fontSize: 55,
      );
      final numberTextStyle = ui.TextStyle(
          color: Colors.white, fontSize: 55, fontWeight: ui.FontWeight.bold);
      final addressParagraphStyle = ui.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          fontWeight: ui.FontWeight.w400);
      final addressParagraphBuilder = ui.ParagraphBuilder(addressParagraphStyle)
        ..pushStyle(addressTextStyle)
        ..addText(franchiseAddress);
      addressParagraphBuilder
        ..pushStyle(numberTextStyle)
        ..addText(franchisePhone);

      final addressConstraints = ui.ParagraphConstraints(width: 1000);
      final paragraph = addressParagraphBuilder.build();
      paragraph.layout(addressConstraints);
      final addressOffset = Offset(500, 1400);
      canvas.drawParagraph(paragraph, addressOffset);

      ////////////////


      final titleTextStyle = ui.TextStyle(
        color: Colors.pink.shade800,
        fontSize: 115,
        fontFamily: "VisbyCF",
      );
      final titleParagraphStyle = ui.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          fontWeight: ui.FontWeight.w900);
      final titleParagraphBuilder = ui.ParagraphBuilder(titleParagraphStyle)
        ..pushStyle(titleTextStyle)
        ..addText(_title);
      final titleConstraints = ui.ParagraphConstraints(width: 1300);
      final titleParagraph = titleParagraphBuilder.build();
      titleParagraph.layout(titleConstraints);
      final titleOffset = Offset(650, 1840);
      canvas.drawParagraph(titleParagraph, titleOffset);

      final picture = recorder.endRecording();
      final img = await picture.toImage(2000, 2000);
      final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

      return pngBytes!.buffer;
    }


    else {
      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: ui.Offset(540, 960), width: 1080, height: 1920),
          Rect.fromCenter(
              center: ui.Offset(540, 960), width: 1080, height: 1920),
          Paint());

      final addressTextStyle = ui.TextStyle(
        fontFamily: "VisbyCF",
        color: Colors.white,
        fontWeight: ui.FontWeight.w400,
        fontSize: 45,
      );
      final numberTextStyle = ui.TextStyle(
          color: Colors.white, fontSize: 50, fontWeight: ui.FontWeight.bold);
      final addressParagraphStyle = ui.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          fontWeight: ui.FontWeight.w400);
      final addressParagraphBuilder = ui.ParagraphBuilder(addressParagraphStyle)
        ..pushStyle(addressTextStyle)
        ..addText(franchiseAddress);
      addressParagraphBuilder
        ..pushStyle(numberTextStyle)
        ..addText(franchisePhone);

      final addressConstraints = ui.ParagraphConstraints(width: 960);
      final paragraph = addressParagraphBuilder.build();
      paragraph.layout(addressConstraints);
      final addressOffset = Offset(60, 1250);
      canvas.drawParagraph(paragraph, addressOffset);

      ////////////////
      double titleTextSize = 90;
      if(_title.length>=15){titleTextSize=75;}

      final titleTextStyle = ui.TextStyle(
        color: Colors.white,
          fontSize: titleTextSize,
        fontFamily: "VisbyCF",
      );
      final titleParagraphStyle = ui.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          fontWeight: ui.FontWeight.w900);
      final titleParagraphBuilder = ui.ParagraphBuilder(titleParagraphStyle)
        ..pushStyle(titleTextStyle)
        ..addText(_title);
      final titleConstraints = ui.ParagraphConstraints(width: 1080);
      final titleParagraph = titleParagraphBuilder.build();
      titleParagraph.layout(titleConstraints);
      final titleOffset = Offset(0, 1650);
      canvas.drawParagraph(titleParagraph, titleOffset);

      final picture = recorder.endRecording();
      final img = await picture.toImage(1080, 1920);
      final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

      return pngBytes!.buffer;
    }
  }

  List<File> processedFiles = <File>[];
  List<Uint8List> processedFilesWeb = <Uint8List>[];
  final RxBool areFilesReady = false.obs;

  String get companyInfo {
    final HomeController homeController = Get.find<HomeController>();
    // return "${homeController.vkUser?.addressFirst ?? ""}\n${homeController.vkUser?.addressSecond ?? ""}\n${homeController.vkUser?.phone ?? ""}";
    return "asd";
  }

  String get companyTitle {
    final HomeController homeController = Get.find<HomeController>();
    return homeController.vkUser?.title ?? "";
  }

  Future<void> _downloadImageFromUInt8List({
    required Uint8List uInt8List,
    double imageQuality = 1,
  }) async {
    final ui.Image image = await decodeImageFromList(uInt8List);

    final html.CanvasElement canvas = html.CanvasElement(
      height: image.height,
      width: image.width,
    );

    final html.CanvasRenderingContext2D ctx = canvas.context2D;

    final List<String> binaryString = <String>[];

    for (final int imageCharCode in uInt8List) {
      final String charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final String data = binaryString.join();

    final String base64 = html.window.btoa(data);

    final html.ImageElement img = html.ImageElement();

    img.src = "data:image/jpeg;base64,$base64";

    final html.ElementStream<html.Event> loadStream = img.onLoad;

    loadStream.listen((html.Event event) {
      ctx.drawImage(img, 0, 0);
      final String dataUrl = canvas.toDataUrl("image/jpeg", imageQuality);
      final html.AnchorElement anchorElement =
          html.AnchorElement(href: dataUrl);
      final HomeController homeController = Get.find<HomeController>();
      anchorElement.download =
          "${homeController.selectedDesignList.first.title}-$companyTitle.png";
      anchorElement.click();
    });
  }



  Future<void> downloadDesign() async {
    try {
      CustomProgressIndicator.openLoadingDialog();
      if (kIsWeb) {
        for (int i = 0; i < processedFilesWeb.length; i++) {
          final Uint8List _imgFile = processedFilesWeb[i];
          await _downloadImageFromUInt8List(uInt8List: _imgFile);
          await CustomProgressIndicator.closeLoadingOverlay();
        }
      } else {
        final File _imgFile = cachedImageFile!;
        final bool? isDownloadSuccess =
            await GallerySaver.saveImage(_imgFile.path);
        await CustomProgressIndicator.closeLoadingOverlay();
        if (isDownloadSuccess == true) {
          AnilSnackBar.downloadSuccessFailSnackBar(
              title: "app.design.download.success.title".tr,
              message: "app.design.download.success.message".tr);
        } else {
          AnilSnackBar.downloadSuccessFailSnackBar(
            title: "app.design.download.failure.title".tr,
            message: "app.design.download.failure.message".tr,);
        }
      }
    } catch (e) {
      debugPrint("ExportDesignDownloadError: $e");
    }
  }




  Future<void> shareDesign() async {
    try {
        List<String> sharePaths = <String>[generatedImageFile!.path];
        Share.shareFiles(
          sharePaths,
          subject: "Tasarım Paylaşım",
        );

    } catch (e) {
      debugPrint("ExportDesignShareError: $e");
    }
  }

  Future<void> discoverMore() async {
    try {
      launchUrl(Uri.parse("whatsapp://send?phone=+905412694524"));

      // launchUrl(
      //   Uri.parse("https://www.instagram.com/vekahverengi.istanbul/"),
      //   mode: LaunchMode.externalNonBrowserApplication,
      // );
    } catch (e) {
      debugPrint("ExportDesignDiscoverMoreError: $e");
    }
  }

  // Anil
  void backButton() {
    Get.back();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    state?.clear();
    update();

    areFilesReady.value = false;
    // processedFiles = <File>[];
    // processedFilesWeb = <Uint8List>[];
    // final HomeController homeController = Get.find();
    // final Map<Design, ScreenshotController> designScreenshotControllerPairs =
    //     <Design, ScreenshotController>{};
    //
    // for (int i = 0;
    //     i < homeController.selectedDesignList.toList().length;
    //     i++) {
    //   designScreenshotControllerPairs.addIf(
    //       true,
    //       homeController.selectedDesignList.toList()[i],
    //       ScreenshotController());
    // }
    //
    // append(() => () async => designScreenshotControllerPairs);
    // _startScreenShots();
    _cacheChosenDesign();
  }
}
