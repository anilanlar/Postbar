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
    print("EXPORT SCREEN BUILT");

    final double _height = MediaQuery
        .of(context)
        .size
        .height;
    final double _width = MediaQuery
        .of(context)
        .size
        .width;
    final double _containerWidth = _width * 0.9;
    const double _maxWidth = 900;

    return Scaffold(
      key: const Key("login_screen_scaffold"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: _width,
          height: _height,
          child: Center(child: Obx(() {
            if (controller.cachedImageFileListener.isFalse) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 3),
                  Container(
                    constraints: const BoxConstraints(maxWidth: _maxWidth),
                    width: _containerWidth,
                    child: Obx(
                          () {
                        if (controller.cachedImageFileListener.isFalse) {
                          return ExportDesignPageFilesNotReady(
                            key: UniqueKey(),
                          );
                        } else {
                          return const ExportDesignPageFilesReady();
                        }
                      },
                    ),
                  ),
                  // const Spacer(flex: 2),
                  if (!kIsWeb)
                    SizedBox(
                      height: 45,
                      width: _width * 0.4,
                      child: CustomGradientButton(
                        text: "app.designs.share".tr.toUpperCase(),
                        onPressed: controller.shareDesign,
                      ),
                    ),
                  if (!kIsWeb) const Spacer(),
                  SizedBox(
                    height: 45,
                    width: _width * 0.4,
                    child: CustomGradientButton(
                      text: "app.designs.download".tr.toUpperCase(),
                      onPressed: controller.downloadDesign,
                    ),
                  ),
                  const Spacer(flex: !kIsWeb ? 3 : 2),
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
                  const Spacer(flex: 3),
                ],
              );
            }
          })),
        ),
      ),
    );
  }
}

class ExportDesignPageFilesNotReady extends GetView<ExportController> {
  const ExportDesignPageFilesNotReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery
        .of(context)
        .size
        .width;
    final double _height = MediaQuery
        .of(context)
        .size
        .height;

    const double _maxWidth = 600;
    const double _maxHeight = 600;
    double _containerWidth =
    (_width * 0.8) >= _maxWidth ? _maxWidth : (_width * 0.8);
    double _containerHeight =
    (_height * 0.5) >= _maxHeight ? _maxHeight : (_height * 0.5);
    _containerHeight = min(_containerHeight, _containerWidth);
    _containerWidth = _containerHeight;
    final Map<Design, ScreenshotController> _pairs = controller.state!;

    return Center(
      child: SizedBox(
        width: _containerWidth,
        height: _containerHeight,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: <Widget>[
            ..._pairs.keys
                .map(
                  (Design design) =>
                  Screenshot<dynamic>(
                    controller: _pairs[design]!,
                    child: Center(
                      child: SizedBox(
                        width: _containerWidth,
                        height: _containerHeight,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.hardEdge,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: design.image ?? '',
                              filterQuality: FilterQuality.high,
                              imageBuilder: (BuildContext context,
                                  ImageProvider<Object> imageProvider) =>
                                  Container(
                                    width: _containerWidth,
                                    height: _containerHeight,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                              placeholder: (BuildContext context, String url) =>
                              const Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                              errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              const SizedBox(),
                            ),
                            Positioned(
                              bottom: _containerHeight *
                                  (design.companyTitlePosBottom ?? 0.015),
                              top: _containerHeight *
                                  (design.companyTitlePosTop ?? 0.91),
                              right: _containerWidth *
                                  (design.companyTitlePosRight ?? 0.04),
                              left: _containerWidth *
                                  (design.companyTitlePosLeft ?? 0.59),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          controller.companyTitle,
                                          style: TextStyles.headline1.copyWith(
                                            fontSize: 128,
                                            fontWeight: FontWeight.w800,
                                            color: design.companyTitleColor ??
                                                const Color(0xFFBB2254),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: _containerHeight *
                                  (design.companyInfoPosBottom ?? 0.15),
                              top: _containerHeight *
                                  (design.companyInfoPosTop ?? 0.74),
                              right: _containerWidth *
                                  (design.companyInfoPosRight ?? 0.25),
                              left: _containerWidth *
                                  (design.companyInfoPosLeft ?? 0.25),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          controller.companyInfo,
                                          style: TextStyles.paragraph.copyWith(
                                            fontSize: 128,
                                            color: design.companyInfoColor ??
                                                const Color(0xFFFFFFFF),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            )
                .toList(),
            /*Center(
              child: Container(
                color: ThemeColors.backgroundColor,
                width: _containerWidth,
                height: _containerHeight,
                child: Center(
                  child: Text(
                    "app.selected.designs.not.ready".tr,
                    style: TextStyles.headline5,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class ExportDesignPageFilesReady extends GetView<ExportController> {
  const ExportDesignPageFilesReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery
        .of(context)
        .size
        .width;
    final double _height = MediaQuery
        .of(context)
        .size
        .height;

    const double _maxWidth = 600;
    const double _maxHeight = 600;
    double _containerWidth =
    (_width * 0.8) >= _maxWidth ? _maxWidth : (_width * 0.8);
    double _containerHeight =
    (_height * 0.5) >= _maxHeight ? _maxHeight : (_height * 0.5);
    _containerHeight = min(_containerHeight, _containerWidth);
    _containerWidth = _containerHeight;

    return Container(
      constraints: const BoxConstraints(maxWidth: _maxWidth),
      width: _containerWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: _maxWidth),
            width: _containerWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
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
              ],
            ),
          ),

          const SizedBox(height: 30),

          //CANVAS CONTAINER
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: MemoryImage(

                    Uint8List.view(controller.generatedImage!),


                ),
              ),),
              width: 500,
              height: 500,
            ),
          ),

          const SizedBox(height: 30),
          // Container(
          //   clipBehavior: Clip.hardEdge,
          //   width: _containerWidth,
          //   height: _containerHeight,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     image: kIsWeb
          //         ? DecorationImage(
          //       fit: BoxFit.cover,
          //       filterQuality: FilterQuality.low,
          //       image: MemoryImage(
          //         controller.processedFilesWeb.first,
          //       ),
          //     )
          //         : DecorationImage(
          //       fit: BoxFit.cover,
          //       filterQuality: FilterQuality.high,
          //       image: FileImage(
          //         controller.cachedImageFile!,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
