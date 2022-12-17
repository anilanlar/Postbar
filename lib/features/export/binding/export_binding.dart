import "package:get/get.dart";
import 'package:postbar/features/export/index.dart';

class ExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ExportController(),
    );
  }
}
