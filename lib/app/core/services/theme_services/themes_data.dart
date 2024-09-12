import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/constants/color_constant.dart';
import '../../../data/constants/extensions/text_style_extensions.dart';
import '../local_db_services/local_db_services.dart';

class ThemesData {
  static final ThemeData lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: ColorConstant.primaryBackgroundColor,
    primaryColor: ColorConstant.primaryColor,
    primaryColorDark: ColorConstant.secondaryColor,
    hoverColor: Colors.white54,
    splashColor: ColorConstant.primaryLightColor,
    primaryColorLight: ColorConstant.primaryLightColor,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primaryColor),
    dividerColor: ColorConstant.viewLineColor,
    appBarTheme: AppBarTheme(
      color: ColorConstant.whiteColor,
      titleTextStyle:  boldTextStyle(
          size: 13, color: ColorConstant.textPrimaryColor),
      iconTheme: IconThemeData(color: ColorConstant.textPrimaryColor),
      systemOverlayStyle:
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
    cardTheme: CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: ColorConstant.primaryColor),
    bottomSheetTheme:
    BottomSheetThemeData(backgroundColor: ColorConstant.whiteColor),
    textTheme: const TextTheme().copyWith(
      bodyText2: primaryTextStyle(
          color: ColorConstant.textPrimaryColor),
      headline2: boldTextStyle(
          size: 30, color: ColorConstant.textColor),
      headline1: boldTextStyle(
          size: 40, color: ColorConstant.textColor),
      headline3: boldTextStyle(color: ColorConstant.textColor),
      button: boldTextStyle(color: ColorConstant.white),
      headline5: secondaryTextStyle( color: ColorConstant.textColor),
      headline4: primaryTextStyle(
          size: 40, color: ColorConstant.textColor),
      headline6: primaryTextStyle(color: ColorConstant.textColor),
      subtitle1: secondaryTextStyle(),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // pageTransitionsTheme:
    // const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
    //   TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    //   TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    //   TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
    //   TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    // }),
  );

  static final ThemeData darkTheme = ThemeData().copyWith(
      scaffoldBackgroundColor: ColorConstant.primaryBackgroundColor,
      highlightColor: ColorConstant.appBackgroundColorDark,
      errorColor: Color(0xFFCF6676),
      appBarTheme: AppBarTheme(
        color: ColorConstant.appBackgroundColorDark,
        titleTextStyle:  boldTextStyle(
            size: Get.height * 0.025, color: ColorConstant.white),
        iconTheme: IconThemeData(color: ColorConstant.white),
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      ),
      primaryColor: ColorConstant.color_primary_black,
      dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
      primaryColorDark: ColorConstant.color_primary_black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      hoverColor: Colors.black12,
      splashColor: ColorConstant.primaryLightColor,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: ColorConstant.appBackgroundColorDark),
      primaryTextTheme: TextTheme(
          headline6: primaryTextStyle(color: Colors.white),
          overline: primaryTextStyle(color: Colors.white)),
      cardTheme: CardTheme(color: ColorConstant.cardBackgroundBlackDark),
      cardColor: ColorConstant.appSecondaryBackgroundColor,
      iconTheme: IconThemeData(color: ColorConstant.whiteColor),
      textTheme: TextTheme().copyWith(
        bodyText2: primaryTextStyle(
            color: ColorConstant.white),
        headline2: boldTextStyle(
            size: 30, color: ColorConstant.white),
        headline1: boldTextStyle(
            size: 40, color: ColorConstant.white),
        headline3: boldTextStyle(color: ColorConstant.primaryColor),
        button: boldTextStyle(color: ColorConstant.white),
        headline5: primaryTextStyle(
            size: 30, color: ColorConstant.white),
        headline4: primaryTextStyle(
            size: 40, color: ColorConstant.white),
        headline6: primaryTextStyle(color: ColorConstant.white),
        subtitle1: secondaryTextStyle(),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
          }));

  final localDbService = Get.find<LocalDBService>();

  ThemeMode get theme =>
      localDbService.isDarkMode() ? ThemeMode.dark : ThemeMode.light;

  static void switchThemes() {
    final localDbService = Get.find<LocalDBService>();
    Get.changeThemeMode(
        localDbService.isDarkMode() ? ThemeMode.light : ThemeMode.dark);
    localDbService.setDarkMode(!localDbService.isDarkMode());
  }
}
