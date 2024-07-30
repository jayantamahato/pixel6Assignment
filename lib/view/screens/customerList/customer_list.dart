import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customer_controller.dart';
import '../../../core/exports.dart';
import '../../../uiHelper/exports.dart';
import '../customer/customer.dart';
import 'widgets/customer_card.dart';

class CustomersScreen extends StatefulWidget {
  static String routeName = '/list';
  const CustomersScreen({super.key});

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
        title: Text(AppString.customerList),
      ),
      body: Obx(
        () => SizedBox(
          height: percentHeight(),
          width: percentWidth(),
          child: _customerController.customerList.isNotEmpty
              ? ListView.builder(
                  itemCount: _customerController.customerList.length,
                  itemBuilder: (context, index) => CustomerCard(
                    controller: _customerController,
                    customerIndex: index,
                    name:
                        _customerController.customerList[index].fullName ?? '',
                    email: _customerController.customerList[index].email ?? '',
                    phone:
                        '+91 ${_customerController.customerList[index].phone}',
                    pan:
                        _customerController.customerList[index].panNumber ?? '',
                    addresses: _customerController.customerList[index].address,
                  ),
                )
              : const Center(child: Text('No customer listed')),
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
        label: Text(AppString.addNewCustomer),
      ),
    );
  }
}
