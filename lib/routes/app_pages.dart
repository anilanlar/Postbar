import "package:get/get.dart";
import 'package:postbar/features/export/index.dart';
import 'package:postbar/features/home/index.dart';
import 'package:postbar/features/login/index.dart';
import 'package:postbar/features/splash/index.dart';
import 'package:postbar/routes/index.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage<LoginScreen>(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      preventDuplicates: true,
    ),
    GetPage<HomeScreen>(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      preventDuplicates: true,
    ),
    GetPage<ExportScreen>(
      name: AppRoutes.EXPORT,
      page: () => const ExportScreen(),
      binding: ExportBinding(),
      preventDuplicates: true,
    ),
  ];
}
