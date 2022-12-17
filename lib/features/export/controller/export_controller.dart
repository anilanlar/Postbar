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

import 'MyCanvas.dart';



class ExportController extends BaseController<Map<Design, ScreenshotController>> {
  ExportController();

  String exportTest = "exptest";
  File? cachedImageFile;
  File? generatedImageFile;

  RxBool cachedImageFileListener= false.obs;
  AddressPainter? addressPainter;
  ui.Image? image;
  ByteBuffer? generatedImage;
  void _cacheChosenDesign() async{
    final String? chosenDesignURL = Get.find<HomeController>().chosenDesignURL;
    if(chosenDesignURL!=null){
      final Uri url = Uri.parse(Get.find<HomeController>().chosenDesignURL!);
      final http.Response response = await http.get(url);
      final Uint8List bytes= response.bodyBytes;
      final Directory temp = await getTemporaryDirectory();
      final String path = '${temp.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      print("PATHH"+ path);
      cachedImageFile = File(path);


      addressPainter = AddressPainter();
      // addressPainter!.cachedImageFileMyCanvas = cachedImageFile;
      final data = await cachedImageFile!.readAsBytes();
      addressPainter!.image = await decodeImageFromList(data);
      this.image = addressPainter!.image;

      print("IMAGE STARTS TO GENERATE");

      generatedImage= await generateImage();
      final Directory tempForGenerated = await getTemporaryDirectory();
      final String pathForGenerated = '${tempForGenerated.path}/image.jpg';
      File(pathForGenerated).writeAsBytesSync(generatedImage!.asUint8List());
      generatedImageFile = File(pathForGenerated);
      print("IMAGE GENERATED");

      cachedImageFileListener.value = !cachedImageFileListener.value;





    }else{
      debugPrint("chosenDesignURL is null");
    }
  }

  Future<ByteBuffer> generateImage() async {

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawImageRect(image!, Rect.fromCircle(center: ui.Offset(1000, 1000), radius: 1000),Rect.fromCenter(center: ui.Offset(1000, 1000), width: 2000, height: 2000), Paint());



    final addressTextStyle = ui.TextStyle(
      fontFamily: "VisbyCF",
      color: Colors.white,
      fontWeight: ui.FontWeight.w400,

      fontSize: 55,
    );
    final numberTextStyle = ui.TextStyle(
      color: Colors.white,
      fontSize: 55,
      fontWeight: ui.FontWeight.bold
    );
    final addressParagraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
        fontWeight : ui.FontWeight.w400
    );
    final addressParagraphBuilder = ui.ParagraphBuilder(addressParagraphStyle)
      ..pushStyle(addressTextStyle)
      ..addText('Yenibatı Mahallesi \n 2429. Sokak \n Botanikpark Evleri Sitesi \n No: 5/P Yenimahalle/Ankara \n');
    addressParagraphBuilder ..pushStyle(numberTextStyle)
      ..addText('0312 566 13 96 ');

    final addressConstraints = ui.ParagraphConstraints(width: 800);
    final paragraph = addressParagraphBuilder.build();
    paragraph.layout(addressConstraints);
    final addressOffset = Offset(600, 1400);
    canvas.drawParagraph(paragraph, addressOffset);



    ////////////////

    final titleTextStyle = ui.TextStyle(
      color: Colors.pink.shade800,
      fontSize: 115,
      fontFamily: "VisbyCF",

    );
    final titleParagraphStyle = ui.ParagraphStyle(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        fontWeight : ui.FontWeight.w900
    );
    final titleParagraphBuilder = ui.ParagraphBuilder(titleParagraphStyle)
      ..pushStyle(titleTextStyle)
      ..addText('ÇAKIRLAR');
    final titleConstraints = ui.ParagraphConstraints(width: 800);
    final titleParagraph = titleParagraphBuilder.build();
    titleParagraph.layout(titleConstraints);
    final titleOffset = Offset(1300, 1840);
    canvas.drawParagraph(titleParagraph, titleOffset);






    final picture = recorder.endRecording();
    final img = await picture.toImage(2000, 2000);
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer;

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
      final html.AnchorElement anchorElement = html.AnchorElement(href: dataUrl);
      final HomeController homeController = Get.find<HomeController>();
      anchorElement.download = "${homeController.selectedDesignList.first.title}-$companyTitle.png";
      anchorElement.click();
    });
  }

  Future<File?> _takeScreenShot(ScreenshotController _screenShotController) async {
    try {
      final String directory = (await getApplicationDocumentsDirectory()).path;
      final Uint8List? pngBytes = await _screenShotController.capture(pixelRatio: 4);
      final HomeController homeController = Get.find<HomeController>();
      final File imgFile = File('$directory/${homeController.selectedDesignList.first.title}-$companyTitle.png')..writeAsBytes(pngBytes!);
      return imgFile;
    } catch (e) {
      debugPrint("WidgetScreenShotError: $e");
      return null;
    }
  }

  Future<Uint8List?> _takeScreenShotWeb(ScreenshotController _screenShotController) async {
    try {
      final Uint8List? pngBytes = await _screenShotController.capture(pixelRatio: 2);
      return pngBytes;
    } catch (e) {
      debugPrint("WidgetScreenShotError: $e");
      return null;
    }
  }

  Future<void> _startScreenShots() async {
    // CustomProgressIndicator.openLoadingDialog();

    final List<Future<dynamic>> futures = <Future<dynamic>>[];

    for (int i = 0; state == null || state!.isEmpty; i++) {
      debugPrint("StateLength: ${state?.length}, LoopCount: $i");
      await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    }

    if (kIsWeb) {
      for (int i = 0; i < state!.length; i++) {
        final Future<Uint8List?> _futureImgFile = _takeScreenShotWeb(state!.values.toList()[i]).then((Uint8List? _imgFile) {
          if (_imgFile != null) {
            processedFilesWeb.add(_imgFile);
          }
          return null;
        });
        futures.add(_futureImgFile);
      }
    } else {
      for (int i = 0; i < state!.length; i++) {
        final Future<File?> _futureImgFile = _takeScreenShot(state!.values.toList()[i]).then((File? _imgFile) {
          if (_imgFile != null) {
            processedFiles.add(_imgFile);
          }
          return null;
        });
        futures.add(_futureImgFile);
      }
    }

    await Future.wait(futures);

    if (kIsWeb) {
      debugPrint("ProcessedFilesWeb: ${processedFilesWeb.map((Uint8List _img) => _img.toString()).toList()}");
    } else {
      debugPrint("ProcessedFiles: ${processedFiles.map((File _img) => _img.path).toList()}");
    }

    await CustomProgressIndicator.closeLoadingOverlay();
    areFilesReady.value = true;
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
          final bool? isDownloadSuccess = await GallerySaver.saveImage(_imgFile.path);
          await CustomProgressIndicator.closeLoadingOverlay();
          if (isDownloadSuccess == true) {
            SnackbarToastUtil.showSnackbar(
              title: "app.design.download.success.title".tr,
              message: "app.design.download.success.message".tr,
            );
          } else {
            SnackbarToastUtil.showErrorSnackbar(
              title: "app.design.download.failure.title".tr,
              message: "app.design.download.failure.message".tr,
            );
          }

      }
    } catch (e) {
      debugPrint("ExportDesignDownloadError: $e");
    }
  }

  // ANIL

  void _singleUseCreateFolder(){
    debugPrint("single use calisti");

    List<String> lst = ["abc","def"];
    final FirebaseStorage storage = FirebaseStorage.instanceFor(app: GlobalVariables.firebase.firebaseApp);
    final Reference storageRef = storage.ref();
    lst.forEach((String element) {
      debugPrint(element);
      // File file = File(path)
      // var uploadTask = storageRef.child('{$element}/null.txt').putFile(null);
    });
  }

  Future<dynamic> _fetchImagesFromStorage() async {
    final FirebaseStorage storage = FirebaseStorage.instanceFor(app: GlobalVariables.firebase.firebaseApp);
    final Reference folder = storage.ref("deneme2");
    debugPrint("ANIL FONKSIYONU");
    final ListResult results = await folder.listAll();
    debugPrint(results.items.length.toString());
    results.items.forEach((Reference item) async {
      debugPrint(await item.getDownloadURL());
    });


    return "fdsa";
  }


  Future<String> uploadImageFile({required Uint8List bytes, required String name}) async {
    debugPrint("Uploading image...");

    CustomProgressIndicator.openLoadingDialog();
    UploadTask uploadTask;

    final Reference storageRef = FirebaseStorage.instanceFor(app: GlobalVariables.firebase.firebaseApp).ref("processed_images_web").child('/$name');
    uploadTask = storageRef.putData(bytes);
    await Future<dynamic>.value(uploadTask);

    final String link = await storageRef.getDownloadURL();
    await CustomProgressIndicator.closeLoadingOverlay();
    return link;
  }

  Future<void> shareDesign() async {
    try {
      if (!kIsWeb) {
        List<String> sharePaths = <String>[generatedImageFile!.path];
        Share.shareFiles(
          sharePaths,
          subject: "Tasarım Paylaşım",
        );
      } else {
        final HomeController homeController = Get.find<HomeController>();
        final String url = await uploadImageFile(bytes: processedFilesWeb.first, name: "${homeController.selectedDesignList.first.title}-$companyTitle.png");

        Share.share(
          url,
          subject: "Tasarım Paylaşım",
        );
      }
    } catch (e) {
      debugPrint("ExportDesignShareError: $e");
    }
  }

  Future<void> discoverMore() async {
    try {
      launchUrl(
        Uri.parse("https://www.instagram.com/vekahverengi.istanbul/"),
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      debugPrint("ExportDesignDiscoverMoreError: $e");
    }
  }

  // Anil
  void backButton(){
    Get.back();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    state?.clear();

    update();
    areFilesReady.value = false;
    processedFiles = <File>[];
    processedFilesWeb = <Uint8List>[];
    final HomeController homeController = Get.find();
    final Map<Design, ScreenshotController> designScreenshotControllerPairs = <Design, ScreenshotController>{};

    for (int i = 0; i < homeController.selectedDesignList.toList().length; i++) {
      designScreenshotControllerPairs.addIf(true, homeController.selectedDesignList.toList()[i], ScreenshotController());
    }

    append(() => () async => designScreenshotControllerPairs);
    // _startScreenShots();
    _cacheChosenDesign();

  }
}
