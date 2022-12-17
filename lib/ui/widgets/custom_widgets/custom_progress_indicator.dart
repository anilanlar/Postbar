import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:postbar/core/utils/index.dart';

class CustomProgressIndicator {
  static bool isShowing = false;

  static Future<void> closeLoadingOverlay() async {
    if (CustomProgressIndicator.isShowing) {
      Navigator.of(Get.overlayContext ?? Get.context!).pop();
      CustomProgressIndicator.isShowing = false;
      await Future<dynamic>.delayed(const Duration(microseconds: 200));
    }
  }

  static Future<void> openLoadingDialog() async {
    if (!CustomProgressIndicator.isShowing && !Get.isSnackbarOpen) {
      CustomProgressIndicator.isShowing = true;
      showDialog(
        context: Get.overlayContext ?? Get.context!,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (_) => const LoadingOverlay(),
      );
    }
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200000),
      lowerBound: 10,
      upperBound: 20,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: SizedBox(
                  height: 90,
                  width: 160,
                  child: Image.asset(
                    GlobalVariables.images.appIconGifPath,
                    gaplessPlayback: true,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
