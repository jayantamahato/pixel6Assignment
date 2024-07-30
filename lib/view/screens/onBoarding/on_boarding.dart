import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customer_controller.dart';
import '../../../core/exports.dart';
import '../../../uiHelper/exports.dart';
import '../customer/customer.dart';
import '../customerList/customer_list.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = '/';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CustomerController _customerController = Get.put(CustomerController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _customerController.getCustomers();
      if (_customerController.customerList.isEmpty) {
        Get.offAllNamed(CustomerScreen.routeName);
        return;
      }

      Get.offAllNamed(CustomersScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
            whiteSpace(height: 50),
            Text(AppString.checkingUser),
          ],
        ),
      ),
    );
  }
}
