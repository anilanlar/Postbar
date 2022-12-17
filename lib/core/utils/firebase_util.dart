import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:postbar/core/utils/index.dart';
import 'package:postbar/firebase_options.dart';
import 'package:postbar/network/index.dart';
import 'package:postbar/routes/index.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class FirebaseUtil {
  const FirebaseUtil();

  static const FirebaseUtil instance = FirebaseUtil();

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint('Handling a background notification: ${message.messageId}');
    AwesomeNotifications().createNotificationFromJsonData(message.data);

  }

  Future<void> firebaseConfigurations() async {
    await _initializeApp();
    debugPrint("run here");

    await Future.wait(
      <Future<dynamic>>[
        _firebaseAuth(),
        _firebaseAnalytics(),
        // if (!kIsWeb) _firebaseMessaging(),
        _firebaseDatabase(),
        if (!kIsWeb) _firebaseRemoteConfig(),
      ],
    );
  }

  Future<void> _initializeApp() async {
    GlobalVariables.firebase.firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _firebaseAuth() async {
    GlobalVariables.firebase.firebaseAuth = FirebaseAuth.instanceFor(app: GlobalVariables.firebase.firebaseApp, persistence: Persistence.INDEXED_DB);
    GlobalVariables.firebase.firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        debugPrint("ALREADY SIGNED IN");

        GlobalVariables.firebase.firebaseAnalytics.setUserId(id: user.uid);
        GlobalVariables.firebase.firebaseAnalytics.setUserProperty(name: 'user_id', value: user.uid);
        GlobalVariables.firebase.firebaseAnalytics.setUserProperty(name: 'user_email', value: user.email);
      } else if (!((Get.currentRoute == AppRoutes.LOGIN) || (Get.currentRoute == AppRoutes.SPLASH))) {
        debugPrint("TO LOG IN");

        GlobalVariables.firebase.firebaseAnalytics.setUserId();
        GlobalVariables.firebase.firebaseAnalytics.setUserProperty(name: 'user_id', value: null);
        GlobalVariables.firebase.firebaseAnalytics.setUserProperty(name: 'user_email', value: null);
        Get.toNamed(AppRoutes.LOGIN);
      }
    });
  }

  Future<void> _firebaseAnalytics() async {
    GlobalVariables.firebase.firebaseAnalytics = FirebaseAnalytics.instanceFor(app: GlobalVariables.firebase.firebaseApp);
    GlobalVariables.firebase.firebaseObserver = FirebaseAnalyticsObserver(analytics: GlobalVariables.firebase.firebaseAnalytics);
  }

  Future<void> _firebaseMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    GlobalVariables.firebase.fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: ${GlobalVariables.firebase.fcmToken}");
  }

  Future<void> _firebaseDatabase() async {
    GlobalVariables.firebase.firebaseDatabase = FirebaseDatabase.instanceFor(app: GlobalVariables.firebase.firebaseApp);

    debugPrint("krelease  "+ kReleaseMode.toString());
    GlobalVariables.firebase.firebaseDatabaseRef = GlobalVariables.firebase.firebaseDatabase.ref(Url.stagingPathFB);
  }

  Future<void> _firebaseRemoteConfig() async {
    final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 200));

      final bool _updated = await _remoteConfig.fetchAndActivate();
      debugPrint("${_updated ? "new" : "old"}RemoteConfig: ${_remoteConfig.getAll().entries.map((MapEntry<String, RemoteConfigValue> entry) => "${entry.key}: ${entry.value.asString().toString()}")}");

      GlobalVariables.firebase.androidAppVersion = _remoteConfig.getValue('app_version_android').asString();
      GlobalVariables.firebase.iosAppVersion = _remoteConfig.getValue('app_version_ios').asString();
      GlobalVariables.firebase.forceUpdate = _remoteConfig.getValue('force_update').asBool();
      GlobalVariables.firebase.playStoreUrl = _remoteConfig.getValue('play_store_url').asString();
      GlobalVariables.firebase.appStoreUrl = _remoteConfig.getValue('app_store_url').asString();
    } catch (e) {
      debugPrint("FirebaseError: ${e.toString()}");
      GlobalVariables.app.restartRequired = true;
    }
  }
}
