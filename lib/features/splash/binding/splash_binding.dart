import "package:get/get.dart";
import 'package:postbar/features/splash/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );
  }
}
