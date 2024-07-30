import 'package:flutter/material.dart';

import '../color/colors.dart';

class AppTheme {
  //Dark Theme

  static dark() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          centerTitle: true,
          surfaceTintColor: AppColor.black,
          backgroundColor: AppColor.darkScaffold),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.darkScaffold,
      primaryColor: AppColor.primary,
    );
  }

//Light Theme
  static light() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.lightScaffold,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.lightScaffold,
      primaryColor: AppColor.primary,
    );
  }
}
