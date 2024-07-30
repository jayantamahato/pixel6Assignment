import 'package:flutter/material.dart';
import 'package:pp/uiHelper/exports.dart';

import '../../core/color/colors.dart';

ElevatedButton appButton(
    {required bool isLoading, required Function fn, required String name}) {
  return ElevatedButton(
    style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(AppColor.primary),
        foregroundColor: WidgetStatePropertyAll<Color>(AppColor.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevation: const WidgetStatePropertyAll(0)),
    onPressed: () {
      isLoading ? null : fn();
    },
    child: isLoading
        ? SizedBox(
            height: adaptiveHeight(height: 20),
            width: adaptiveWidth(width: 20),
            child: CircularProgressIndicator(color: AppColor.white),
          )
        : Text(name),
  );
}
