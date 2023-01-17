import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/export/index.dart';
import 'package:postbar/model/index.dart';
import 'package:postbar/ui/widgets/index.dart';
import 'package:screenshot/screenshot.dart';

import '../controller/MyCanvas.dart';

class ExportScreen extends GetView<ExportController> {
  const ExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _containerWidth = _screenWidth * 0.9;
    const double _maxWidth = 900;
    debugPrint("SCREEN HEIGHT AND WIDTH$_screenHeight $_screenWidth");
    return Scaffold(
      key: const Key("login_screen_scaffold"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: _screenWidth,
          height: _screenHeight,
          child: Center(child: Obx(() {

            if (controller.cachedImageFileListener.isFalse) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   // const Spacer(flex: 3),

                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: Image.asset(
                          GlobalVariables.images.appLogoPath,
                          width: 100,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      TextButton(
                        onPressed: controller.backButton,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20)),
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                        child: const Text(
                          "< GERİ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "app.selected.designs.ready".tr,
                          style: TextStyles.headline5,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    // color: Colors.blue,
                    constraints: const BoxConstraints(maxWidth: _maxWidth),
                    width: _containerWidth,
                    height: _screenHeight* 0.8,
                    child: Obx(
                      () {
                        if (controller.cachedImageFileListener.isFalse) {
                          return CircularProgressIndicator.adaptive();
                        } else {
                          return const ExportDesignPageFilesReady();
                        }
                      },
                    ),
                  ),
                  // const Spacer(flex: 2),
                  // _buttons(controller, _width),

                  // const Spacer(flex: 3),
                ],
              );
            }
          })),
        ),
      ),
    );
  }

  Widget _buttons(ExportController exportController, double _width) {
    if (exportController.homeController.isPostorStory.value == "Post") {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        if (!kIsWeb)
          SizedBox(
            height: 45,
            width: _width * 0.4,
            child: CustomGradientButton(
              text: "app.designs.share".tr.toUpperCase(),
              onPressed: controller.shareDesign,
            ),
          ),
        // if (!kIsWeb) const Spacer(),
            const SizedBox(height: 15),

            SizedBox(
          height: 45,
          width: _width * 0.4,
          child: CustomGradientButton(
            text: "app.designs.download".tr.toUpperCase(),
            onPressed: controller.downloadDesign,
          ),
        ),
        // const Spacer(flex: !kIsWeb ? 3 : 2),
            const SizedBox(height: 15),

            Container(
          height: 45,
          width: _width * 0.4,
          color: Colors.transparent,
          child: CustomGradientButton(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.white,
                blurRadius: 40,
                offset: Offset.zero,
              ),
            ],
            gradient: const LinearGradient(
              colors: <Color>[
                ThemeColors.thirdColor,
                ThemeColors.fourthColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            text: "app.designs.discover".tr.toUpperCase(),
            onPressed: controller.discoverMore,
          ),
        ),
      ]);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

            if (!kIsWeb)
              SizedBox(
                height: 45,
                width: _width * 0.35,
                child: CustomGradientButton(
                  text: "app.designs.share".tr.toUpperCase(),
                  onPressed: controller.shareDesign,
                ),
              ),
            // if (!kIsWeb) const Spacer(),
            SizedBox(
              height: 45,
              width: _width * 0.35,
              child: CustomGradientButton(
                text: "app.designs.download".tr.toUpperCase(),
                onPressed: controller.downloadDesign,
              ),
            ),
            // const Spacer(flex: !kIsWeb ? 3 : 2),

          ]),
          const SizedBox(height: 20),

          Container(
            height: 45,
            width: _width * 0.35,
            color: Colors.transparent,
            child: CustomGradientButton(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 40,
                  offset: Offset.zero,
                ),
              ],
              gradient: const LinearGradient(
                colors: <Color>[
                  ThemeColors.thirdColor,
                  ThemeColors.fourthColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              text: "app.designs.discover".tr.toUpperCase(),
              onPressed: controller.discoverMore,
            ),
          ),
        ],
      );
    }
  }
}


class ExportDesignPageFilesReady extends GetView<ExportController> {
  const ExportDesignPageFilesReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;

    //PLATFORM IS ANDROID
    if(Theme.of(context).platform == TargetPlatform.android){
      if(controller.homeController.isPostorStory.value=="Post"){return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          //CANVAS CONTAINER
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: MemoryImage(
                    Uint8List.view(controller.generatedImage!),
                  ),
                ),
              ),
              width: _screenWidth* 0.9,
              height: _screenWidth * 0.9,
            ),
          ),
          if (!kIsWeb)
            SizedBox(
              height: 45,
              width: _screenWidth * 0.4,
              child: CustomGradientButton(
                text: "app.designs.share".tr.toUpperCase(),
                onPressed: controller.shareDesign,
              ),
            ),
          // if (!kIsWeb) const Spacer(),
          // const SizedBox(height: 15),

          SizedBox(
            height: 45,
            width: _screenWidth * 0.4,
            child: CustomGradientButton(
              text: "app.designs.download".tr.toUpperCase(),
              onPressed: controller.downloadDesign,
            ),
          ),
          // const Spacer(flex: !kIsWeb ? 3 : 2),
          // const SizedBox(height: 15),
          Container(
            height: 45,
            width: _screenWidth * 0.4,
            color: Colors.transparent,
            child: CustomGradientButton(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 40,
                  offset: Offset.zero,
                ),
              ],
              gradient: const LinearGradient(
                colors: <Color>[
                  ThemeColors.thirdColor,
                  ThemeColors.fourthColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              text: "app.designs.discover".tr.toUpperCase(),
              onPressed: controller.discoverMore,
            ),
          ),

        ],
      );}
      else{
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const SizedBox(height: 20),
            // Spacer()
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  image: MemoryImage(
                    Uint8List.view(controller.generatedImage!),
                  ),
                ),
              ),
              width: _screenHeight* 0.6 * 1080/1920 ,
              height: _screenHeight* 0.6,
            ),
            // const SizedBox(height: 20),

            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

              if (!kIsWeb)
                SizedBox(
                  height: 45,
                  width: _screenWidth * 0.35,
                  child: CustomGradientButton(
                    text: "app.designs.share".tr.toUpperCase(),
                    onPressed: controller.shareDesign,
                  ),
                ),
              // if (!kIsWeb) const Spacer(),
              SizedBox(
                height: 45,
                width: _screenWidth * 0.35,
                child: CustomGradientButton(
                  text: "app.designs.download".tr.toUpperCase(),
                  onPressed: controller.downloadDesign,
                ),
              ),
              // const Spacer(flex: !kIsWeb ? 3 : 2),

            ]),
            // const SizedBox(height: 20),

            Container(
              height: 45,
              width: _screenWidth * 0.35,
              color: Colors.transparent,
              child: CustomGradientButton(
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 40,
                    offset: Offset.zero,
                  ),
                ],
                gradient: const LinearGradient(
                  colors: <Color>[
                    ThemeColors.thirdColor,
                    ThemeColors.fourthColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                text: "app.designs.discover".tr.toUpperCase(),
                onPressed: controller.discoverMore,
              ),
            ),
          ],
        );}
    }

    //PLATFORM IS IOS
    else{
      if(controller.homeController.isPostorStory.value=="Post"){return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          //CANVAS CONTAINER
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: MemoryImage(
                    Uint8List.view(controller.generatedImage!),
                  ),
                ),
              ),
              width: _screenWidth* 0.9,
              height: _screenWidth * 0.9,
            ),
          ),
          if (!kIsWeb)
            SizedBox(
              height: 45,
              width: _screenWidth * 0.4,
              child: CustomGradientButton(
                text: "app.designs.share".tr.toUpperCase(),
                onPressed: controller.shareDesign,
              ),
            ),
          // if (!kIsWeb) const Spacer(),
          // const SizedBox(height: 15),
          // const Spacer(flex: !kIsWeb ? 3 : 2),
          // const SizedBox(height: 15),
          Container(
            height: 45,
            width: _screenWidth * 0.4,
            color: Colors.transparent,
            child: CustomGradientButton(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 40,
                  offset: Offset.zero,
                ),
              ],
              gradient: const LinearGradient(
                colors: <Color>[
                  ThemeColors.thirdColor,
                  ThemeColors.fourthColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              text: "app.designs.discover".tr.toUpperCase(),
              onPressed: controller.discoverMore,
            ),
          ),

        ],
      );}
      else{
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const SizedBox(height: 20),
            // Spacer()
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  image: MemoryImage(
                    Uint8List.view(controller.generatedImage!),
                  ),
                ),
              ),
              width: _screenHeight* 0.6 * 1080/1920 ,
              height: _screenHeight* 0.6,
            ),
            // const SizedBox(height: 20),

            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

              if (!kIsWeb)

              // if (!kIsWeb) const Spacer(),
              Container(
                height: 45,
                width: _screenWidth * 0.35,
                color: Colors.transparent,
                child: CustomGradientButton(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 40,
                      offset: Offset.zero,
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: <Color>[
                      ThemeColors.thirdColor,
                      ThemeColors.fourthColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  text: "app.designs.discover".tr.toUpperCase(),
                  onPressed: controller.discoverMore,
                ),
              ),

              SizedBox(
                height: 45,
                width: _screenWidth * 0.35,
                child: CustomGradientButton(
                  text: "app.designs.share".tr.toUpperCase(),
                  onPressed: controller.shareDesign,
                ),
              ),
            ]),
            // const SizedBox(height: 20),


          ],
        );}
    }




  }

  Widget _readyDesign(String isPostorStory, double _screenWidth) {
    if (isPostorStory == "Post") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            image: MemoryImage(
              Uint8List.view(controller.generatedImage!),
            ),
          ),
        ),
        width: 229.5,
        height: 408,
      );
    }
  }
}
