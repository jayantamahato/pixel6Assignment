import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pp/core/exports.dart';
import 'package:pp/view/screens/customer/customer.dart';
import 'package:pp/view/screens/customerList/widgets/customer_card.dart';

import '../../../controller/customer_controller.dart';
import '../../../uiHelper/exports.dart';
import '../../widgets/address_card.dart';

class CustomersScreen extends StatefulWidget {
  static String routeName = '/list';
  CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final CustomerController _customerController = Get.put(CustomerController());
  @override
  void initState() {
    _customerController.getCustomers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: Obx(
        () => SizedBox(
          height: percentHeight(),
          width: percentWidth(),
          child: ListView.builder(
            itemCount: _customerController.customerList.length,
            itemBuilder: (context, index) => CustomerCard(
              controller: _customerController,
              customerIndex: index,
              name: _customerController.customerList[index].fullName ?? '',
              email: _customerController.customerList[index].email ?? '',
              phone: '+91 ${_customerController.customerList[index].phone}',
              pan: _customerController.customerList[index].panNumber ?? '',
              addresses: _customerController.customerList[index].address,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: WidgetStatePropertyAll(AppColor.primary),
          foregroundColor: WidgetStatePropertyAll(AppColor.white),
        ),
        onPressed: () {
          //clear personal input controller
          _customerController.fullNameController.clear();
          _customerController.phoneController.clear();
          _customerController.emailController.clear();
          _customerController.panInputController.clear();
          //address clear
          _customerController.firstAddressLineController.clear();
          _customerController.secondAddressLineController.clear();
          _customerController.cityController.clear();
          _customerController.postalController.clear();
          _customerController.stateController.clear();
          _customerController.address.clear();
          _customerController.cityList.clear();
          _customerController.stateList.clear();
          Get.toNamed(CustomerScreen.routeName);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Customer'),
      ),
    );
  }
}
