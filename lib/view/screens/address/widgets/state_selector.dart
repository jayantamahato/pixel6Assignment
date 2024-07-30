import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../uiHelper/exports.dart';

class StateSelector extends StatelessWidget {
  StateSelector({super.key});

  final CustomerController _customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField(
        style: customTextStyle(fontSize: 15, weight: FontWeight.normal)
            .copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColor.white
                    : AppColor.black),
        value: _customerController.stateController.text,
        decoration: InputDecoration(
          labelText: AppString.state,
          border: const OutlineInputBorder(),
        ),
        items: _customerController.stateList.map((data) {
          return DropdownMenuItem<String>(
            value: '${data.name}',
            child: Text(data.name),
          );
        }).toList(),
        onChanged: (value) {
          _customerController.stateController.text = '$value';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppString.stateError;
          }
          return null;
        },
      ),
    );
  }
}
