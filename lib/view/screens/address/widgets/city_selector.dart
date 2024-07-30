import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../uiHelper/exports.dart';

class CitySelector extends StatelessWidget {
  CitySelector({super.key});

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
        value: _customerController.cityController.text,
        decoration: InputDecoration(
          labelText: AppString.city,
          border: const OutlineInputBorder(),
        ),
        items: _customerController.cityList.map((data) {
          return DropdownMenuItem<String>(
            value: '${data.name}',
            child: Text(data.name),
          );
        }).toList(),
        onChanged: (value) {
          _customerController.cityController.text = '$value';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppString.cityError;
          }
          return null;
        },
      ),
    );
  }
}
