import 'package:get/get.dart';

SnackbarController customSnackbar(
    {required String message, required SnackBarType type}) {
  if (type == SnackBarType.error) {
    return Get.snackbar('Error', message);
  } else {
    return Get.snackbar('Error', message);
  }
}

class SnackBarType {
  static const String error = 'Error';
  static const String success = 'Error';
}
