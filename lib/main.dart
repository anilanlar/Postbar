import "dart:async";
import "dart:developer";

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:postbar/app.dart";
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/routes/index.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> initServices() async {
  if (!kIsWeb) {
    ConnectivityUtil.configureConnectivityStream();
  }
  await Future.wait(
    <Future<dynamic>>[
      FirebaseUtil.instance.firebaseConfigurations(),
      StorageUtil.init(),
    ],
  );
}

Future<void> main() async {
  debugPrint = (String? message, {int? wrapWidth}) {
    if (!kReleaseMode) {
      log(message.toString());
    }
  };

  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runZonedGuarded<Future<void>>(
    () async {
      if (kIsWeb) {
        setPathUrlStrategy();
        final String defaultRouteName = WidgetsBinding.instance.window.defaultRouteName;
        if (!(defaultRouteName == AppRoutes.SPLASH || defaultRouteName == AppRoutes.BASE)) {
          SystemNavigator.routeUpdated(routeName: AppRoutes.BASE, previousRouteName: null);
        }
      } else {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      }
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
        (_) {
          runApp(
            const VkFranchiseApp(),
          );
        },
      );
    },
    (Object error, StackTrace stack) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
    },
  );
}
