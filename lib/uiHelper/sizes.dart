import 'package:get/get.dart';

double percentWidth({double percent = 100}) {
  double screenWidth = Get.width;
  return (screenWidth * percent) / 100;
}

double percentHeight({double percent = 100}) {
  double screenHeight = Get.height;
  return (screenHeight * percent) / 100;
}

double adaptiveWidth({double width = 0.0}) {
  return width;
}

double adaptiveHeight({double height = 0.0}) {
  return height;
}

double adaptivePadding({double padding = 0.0}) {
  return padding;
}

double adaptiveMargin({double margin = 0.0}) {
  return margin;
}
