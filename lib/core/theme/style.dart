import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postbar/core/theme/index.dart';

class Style {
  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: ThemeColors.backgroundColor,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    primaryColor: ThemeColors.primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 2,
      color: ThemeColors.appBarColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ThemeColors.appBarTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: 80,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ThemeColors.bottomNavigationBarBackgroundColor,
      selectedItemColor: ThemeColors.selectedItemColor,
      unselectedItemColor: ThemeColors.unselectedItemColor,
      selectedIconTheme: IconThemeData(size: 28, opacity: 1, color: ThemeColors.selectedItemColor),
      unselectedIconTheme: IconThemeData(size: 24, opacity: 1, color: ThemeColors.unselectedItemColor),
      selectedLabelStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: ThemeColors.secondaryColor,
      errorColor: ThemeColors.errorColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.ptSansTextTheme(
      ThemeData.light().textTheme.copyWith(
            headline1: ThemeData.light().textTheme.headline1?.copyWith(color: ThemeColors.primaryTextColor),
            headline2: ThemeData.light().textTheme.headline2?.copyWith(color: ThemeColors.primaryTextColor),
            headline3: ThemeData.light().textTheme.headline3?.copyWith(color: ThemeColors.primaryTextColor),
            headline4: ThemeData.light().textTheme.headline4?.copyWith(color: ThemeColors.primaryTextColor),
            headline5: ThemeData.light().textTheme.headline5?.copyWith(color: ThemeColors.primaryTextColor),
            headline6: ThemeData.light().textTheme.headline6?.copyWith(color: ThemeColors.primaryTextColor),
            subtitle1: ThemeData.light().textTheme.subtitle1?.copyWith(color: ThemeColors.primaryTextColor),
            subtitle2: ThemeData.light().textTheme.subtitle2?.copyWith(color: ThemeColors.primaryTextColor),
            bodyText1: ThemeData.light().textTheme.bodyText1?.copyWith(color: ThemeColors.primaryTextColor),
            bodyText2: ThemeData.light().textTheme.bodyText2?.copyWith(color: ThemeColors.primaryTextColor),
            button: ThemeData.light().textTheme.button?.copyWith(color: ThemeColors.primaryTextColor),
            caption: ThemeData.light().textTheme.caption?.copyWith(color: ThemeColors.primaryTextColor),
            overline: ThemeData.light().textTheme.overline?.copyWith(color: ThemeColors.primaryTextColor),
          ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: ThemeColors.backgroundColor,
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    primaryColor: ThemeColors.primaryColor,
    appBarTheme: const AppBarTheme(
      color: ThemeColors.appBarColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ThemeColors.appBarTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: 80,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ThemeColors.bottomNavigationBarBackgroundColor,
      selectedIconTheme: IconThemeData(size: 28, opacity: 1, color: ThemeColors.selectedItemColor),
      unselectedIconTheme: IconThemeData(size: 24, opacity: 1, color: ThemeColors.unselectedItemColor),
      selectedLabelStyle: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      unselectedLabelStyle: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: ThemeColors.secondaryColor,
      errorColor: ThemeColors.errorColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: GoogleFonts.ptSansTextTheme(
      ThemeData.dark().textTheme.copyWith(
            headline1: ThemeData.dark().textTheme.headline1?.copyWith(color: ThemeColors.primaryTextColor),
            headline2: ThemeData.dark().textTheme.headline2?.copyWith(color: ThemeColors.primaryTextColor),
            headline3: ThemeData.dark().textTheme.headline3?.copyWith(color: ThemeColors.primaryTextColor),
            headline4: ThemeData.dark().textTheme.headline4?.copyWith(color: ThemeColors.primaryTextColor),
            headline5: ThemeData.dark().textTheme.headline5?.copyWith(color: ThemeColors.primaryTextColor),
            headline6: ThemeData.dark().textTheme.headline6?.copyWith(color: ThemeColors.primaryTextColor),
            subtitle1: ThemeData.dark().textTheme.subtitle1?.copyWith(color: ThemeColors.primaryTextColor),
            subtitle2: ThemeData.dark().textTheme.subtitle2?.copyWith(color: ThemeColors.primaryTextColor),
            bodyText1: ThemeData.dark().textTheme.bodyText1?.copyWith(color: ThemeColors.primaryTextColor),
            bodyText2: ThemeData.dark().textTheme.bodyText2?.copyWith(color: ThemeColors.primaryTextColor),
            button: ThemeData.dark().textTheme.button?.copyWith(color: ThemeColors.primaryTextColor),
            caption: ThemeData.dark().textTheme.caption?.copyWith(color: ThemeColors.primaryTextColor),
            overline: ThemeData.dark().textTheme.overline?.copyWith(color: ThemeColors.primaryTextColor),
          ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: ThemeColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
