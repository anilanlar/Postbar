import 'package:get/get.dart';
import 'package:postbar/routes/index.dart';

class LoginHelper {
  static RxBool isLoggedIn = false.obs
    ..listen((bool value) {
      if (!value) {
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    });
}
