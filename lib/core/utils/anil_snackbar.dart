



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';

import '../theme/colors.dart';

class AnilSnackBar{
  static SnackbarController downloadSuccessFailSnackBar(
      {required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundGradient: const LinearGradient(
        colors: <Color>[
          ThemeColors.thirdColor,
          ThemeColors.fourthColor,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }
}

