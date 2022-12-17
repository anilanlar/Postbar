import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/splash/index.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      key: Key("splash_screen_scaffold"),
      body: Center(
        key: Key("splash_screen_center_widget"),
        child: SplashRotateAnimationIcon(
          key: Key("splash_screen_rotated_icon"),
        ),
      ),
    );
  }
}

class SplashRotateAnimationIcon extends StatefulWidget {
  const SplashRotateAnimationIcon({Key? key}) : super(key: key);

  @override
  _SplashRotateAnimationIconState createState() => _SplashRotateAnimationIconState();
}

class _SplashRotateAnimationIconState extends State<SplashRotateAnimationIcon> with TickerProviderStateMixin {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
        height: 360,
        width: 640,
        child: Image.asset(
          GlobalVariables.images.appIconGifPath,
          gaplessPlayback: true,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
