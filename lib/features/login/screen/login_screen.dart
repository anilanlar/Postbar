import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:get/get.dart";
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/features/login/index.dart';
import 'package:postbar/ui/widgets/index.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: const Key("login_screen_scaffold"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(flex: 4),
              Text(
                "app.login.title".tr,
                style: TextStyles.headline4,
              ),
              const Spacer(),
              CustomInputBox(
                labelText: "app.login.email.label".tr.toUpperCase(),
                hintText: "app.login.email.hint".tr,
                textEditingController: controller.emailController,
              ),
              const Spacer(),
              Builder(
                builder: (BuildContext context) {
                  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
                  return ValueListenableBuilder<bool>(
                    valueListenable: obscureText,
                    builder: (BuildContext context, bool? value, Widget? child) {
                      return CustomInputBox(
                        labelText: "app.login.password.label".tr.toUpperCase(),
                        hintText: "app.login.password.hint".tr,
                        textEditingController: controller.passwordController,
                        obscureText: value == true,
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            value == true ? "assets/svg/eye-closed.svg" : "assets/svg/eye.svg",
                            color: Colors.white,
                          ),
                          onPressed: () => obscureText.value = !obscureText.value,
                        ),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              Container(
                height: 45,
                width: _width * 0.4,
                color: Colors.transparent,
                child: CustomGradientButton(
                  text: "app.login.button".tr,
                  onPressed: controller.login,
                ),
              ),
              if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) const Spacer(),
                Container(
                  height: 45,
                  width: _width * 0.4,
                  color: Colors.transparent,
                  child: CustomGradientButton(
                    text: "app.contact.button".tr,
                    onPressed: controller.contact,
                  ),
                ),
              const Spacer(flex: 3),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  GlobalVariables.images.appLogoPath,
                  width: 100,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
