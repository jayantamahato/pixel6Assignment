import 'package:flutter/material.dart';

import '../color/colors.dart';

class AppTheme {
  //Dark Theme

  static dark() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          centerTitle: true,
          surfaceTintColor: AppColor.black,
          backgroundColor: AppColor.black),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.darkScaffold,
      primaryColor: AppColor.primary,
    );
  }

//Light Theme
  static light() {
    return ThemeData(
      appBarTheme: AppBarTheme(surfaceTintColor: AppColor.white),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.lightScaffold,
      primaryColor: AppColor.primary,
    );
  }
}
