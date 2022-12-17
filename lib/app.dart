import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";
import 'package:postbar/core/app/strings.dart';
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/routes/index.dart';
import 'package:postbar/ui/widgets/index.dart';
import "package:responsive_framework/responsive_framework.dart";

class VkFranchiseApp extends StatelessWidget {
  const VkFranchiseApp({Key? key}) : super(key: key);

  static GlobalKey vkFranchiseAppKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        key: vkFranchiseAppKey,
        title: AppStrings.appName,
        theme: Style.lightTheme,
        darkTheme: Style.darkTheme,
        themeMode: ThemeMode.light,
        translations: TranslationsUtil(),
        locale: TranslationsUtil.locale,
        fallbackLocale: TranslationsUtil.fallbackLocale,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale("tr", "TR"),
          Locale("en", "US"),
        ],
        getPages: AppPages.routes,
        initialRoute: AppRoutes.SPLASH,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorScreen(errorDetails: errorDetails);
          };
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQueryData.copyWith(
              platformBrightness: Brightness.light,
              textScaleFactor: 1,
              alwaysUse24HourFormat: true,
              boldText: false,
            ),
            child: ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 1000,
              minWidth: 450,
              defaultScale: true,
              breakpoints: const <ResponsiveBreakpoint>[
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ],
              background: Container(
                color: ThemeColors.backgroundColor,
                child: Center(
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
                ),
              ),
            ),
          );
        },
        enableLog: kDebugMode,
        logWriterCallback: (String text, {bool isError = false}) {
          debugPrint("GetXLog: $text");
        },
        navigatorObservers: <NavigatorObserver>[
          GetObserver(),
          GlobalVariables.firebase.firebaseObserver,
        ],
      ),
    );
  }
}
