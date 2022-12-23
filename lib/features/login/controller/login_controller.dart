import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postbar/core/base/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/login/index.dart';
import 'package:postbar/model/index.dart';
import 'package:postbar/routes/index.dart';
import 'package:postbar/ui/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends BaseRepositoryController<LoginRepository, LoginProvider, List<Design>?> {
  LoginController() : super(repository: LoginRepository());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {

    dynamic uptodateChecker = (await GlobalVariables.firebase.firebaseDatabaseRef.child("0000_isUptodate").get()).value;
    if (uptodateChecker["isUptodate"]==false){
      AnilSnackBar.downloadSuccessFailSnackBar(
          title: "UYARI",
          message: "UYGULAMANIZI GÜNCELLEMENİZ GEREKMEKTEDİR");

      debugPrint("not updated");
    }
    else{
      if (!emailController.text.isEmail || passwordController.text.isEmpty) {
        SnackbarToastUtil.showErrorSnackbar(
          title: "app.login.credentials.empty.title".tr,
          message: "app.login.credentials.empty.message".tr,
        );
        return;
      }

      CustomProgressIndicator.openLoadingDialog();
      try {
        final UserCredential userCredential = await GlobalVariables.firebase.firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (userCredential.user != null) {
          await CustomProgressIndicator.closeLoadingOverlay();
          Get.offAllNamed(AppRoutes.HOME);
        } else {
          await CustomProgressIndicator.closeLoadingOverlay();
          SnackbarToastUtil.showErrorSnackbar(
            title: "app.login.error.title".tr,
            message: "app.login.error.message".tr,
          );
        }
      } catch (e) {
        debugPrint("LoginError: $e");
        await CustomProgressIndicator.closeLoadingOverlay();
        SnackbarToastUtil.showErrorSnackbar(
          title: "app.login.error.title".tr,
          message: "app.login.error.message".tr,
        );
      }
    }

  }

  Future<void> contact() async {
    try {
      launchUrl(Uri.parse("whatsapp://send?phone=+905412694524"));
    } catch (e) {
      debugPrint("LaunchWhatsappError: $e");
    }
  }
}
