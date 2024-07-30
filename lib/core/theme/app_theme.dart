import 'package:flutter/material.dart';

import '../color/colors.dart';

class AppTheme {
  //Dark Theme

  static dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.darkScaffold,
      primaryColor: AppColor.primary,
    );
  }

//Light Theme
  static light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.lightScaffold,
      primaryColor: AppColor.primary,
    );
  }
}
