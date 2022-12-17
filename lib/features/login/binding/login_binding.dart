import "package:get/get.dart";
import 'package:postbar/features/login/index.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(),
    );
  }
}
