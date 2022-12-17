import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class GlobalVariables {
  static _App app = _App();
  static _Firebase firebase = _Firebase();
  static _Images images = _Images();
}

class _App {
  bool restartRequired = false;
}

class _Firebase {
  late final FirebaseApp firebaseApp;
  late final FirebaseAuth firebaseAuth;
  late final FirebaseAnalytics firebaseAnalytics;
  late final FirebaseAnalyticsObserver firebaseObserver;
  late final FirebaseDatabase firebaseDatabase;
  late final DatabaseReference firebaseDatabaseRef;
  late String? fcmToken;
  late final String androidAppVersion;
  late final String playStoreUrl;
  late final String iosAppVersion;
  late final String appStoreUrl;
  late final bool forceUpdate;
}

class _Images {
  String get appIconPath => "assets/launcher/icon.png";
  String get appLogoPath => "assets/launcher/logo.png";
  String get appIconGifPath => "assets/launcher/icon_gif.gif";
  String get loadingIndicatorPath => "assets/launcher/loading_indicatior_dots.svg";
}
