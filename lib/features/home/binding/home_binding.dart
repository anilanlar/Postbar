import "package:get/get.dart";
import 'package:postbar/features/home/index.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
  }
}
