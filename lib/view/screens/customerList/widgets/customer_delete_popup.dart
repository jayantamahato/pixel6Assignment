import 'package:flutter/material.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../uiHelper/exports.dart';

AlertDialog confirmCustomerDeletePopUp(
    {required BuildContext context,
    required int index,
    required CustomerController customerController}) {
  return AlertDialog(
    actions: [
      TextButton(
        onPressed: () async {
          bool res = await customerController.deleteCustomer(index: index);
          if (res) {
            await customerController.getCustomers();
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          AppString.yes,
          style: customTextStyle(fontSize: 12, weight: FontWeight.w500)
              .copyWith(color: AppColor.success),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppString.no,
            style: customTextStyle(fontSize: 12, weight: FontWeight.w500)
                .copyWith(color: AppColor.error)),
      )
    ],
    title: Text(AppString.warning),
    content: Text(AppString.areYouWantToDelete),
  );
}
