import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customer_controller.dart';
import '../../../core/exports.dart';
import '../../../uiHelper/exports.dart';
import '../../widgets/app_button.dart';
import '../../widgets/input.dart';
import 'widgets/pan_input.dart';
import '../address/address.dart';

class CustomerScreen extends StatefulWidget {
  static String routeName = '/add';
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final CustomerController _customerController = Get.put(CustomerController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.customer),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whiteSpace(height: 24),
                    Text(
                      'Personal Information',
                      style:
                          customTextStyle(fontSize: 12, weight: FontWeight.bold)
                              .copyWith(color: AppColor.primary),
                    ),
                    whiteSpace(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColor.white
                            : AppColor.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PanInput(
                            controller: _customerController.panInputController,
                          ),
                          whiteSpace(height: 24),
                          TextInput(
                            controller: _customerController.fullNameController,
                            labelText: AppString.fullName,
                            errorMessage: AppString.fullNameError,
                            isRequired: true,
                          ),
                          whiteSpace(height: 24),
                          TextInput(
                            controller: _customerController.phoneController,
                            labelText: AppString.phone,
                            errorMessage: AppString.phoneError,
                            isRequired: true,
                          ),
                          whiteSpace(height: 24),
                          TextInput(
                            controller: _customerController.emailController,
                            labelText: AppString.email,
                            errorMessage: AppString.emailError,
                            isRequired: true,
                          ),
                        ],
                      ),
                    ),
                    whiteSpace(height: 30),
                  ],
                ),
              ),
              whiteSpace(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        height: adaptiveHeight(height: 60),
        child: Obx(
          () => SizedBox(
            width: percentWidth(),
            child: appButton(
              isLoading: _customerController.isLoading.isTrue,
              fn: () {
                _saveCustomer();
              },
              name: AppString.next,
            ),
          ),
        ),
      ),
    );
  }

  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      _customerController.saveCustomer();
      Get.toNamed(AddressScreen.routeName, arguments: Get.arguments);
    }
  }
}
