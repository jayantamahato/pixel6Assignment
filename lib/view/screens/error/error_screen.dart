import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../uiHelper/exports.dart';
import '../../widgets/app_button.dart';
import '../onBoarding/on_boarding.dart';

class ErrorScreen extends StatelessWidget {
  static String routeName = '/error';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Error',
              style: customTextStyle(fontSize: 15, weight: FontWeight.bold),
            ),
            whiteSpace(height: 20),
            Text('${Get.arguments['msg']}')
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: appButton(
            isLoading: false,
            fn: () {
              Get.offAllNamed(OnboardingScreen.routeName);
            },
            name: 'Retry'),
      ),
    );
  }
}
