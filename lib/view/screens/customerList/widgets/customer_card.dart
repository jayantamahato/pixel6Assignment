import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../uiHelper/exports.dart';
import '../../../widgets/address_card.dart';
import '../../address/address.dart';
import '../../customer/customer.dart';
import 'customer_delete_popup.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String pan;
  final int customerIndex;
  final List addresses;
  final CustomerController controller;
  const CustomerCard(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.pan,
      required this.addresses,
      required this.controller,
      required this.customerIndex});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.grey.withOpacity(0.3) : AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            width: percentWidth(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          customTextStyle(fontSize: 16, weight: FontWeight.bold)
                              .copyWith(color: AppColor.primary),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 15,
                        ),
                        whiteSpace(width: 8),
                        Text(
                          phone,
                          style: customTextStyle(
                                  fontSize: 12, weight: FontWeight.normal)
                              .copyWith(color: AppColor.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          size: 15,
                        ),
                        whiteSpace(width: 8),
                        Text(
                          email,
                          style: customTextStyle(
                                  fontSize: 12, weight: FontWeight.normal)
                              .copyWith(color: AppColor.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 15,
                        ),
                        whiteSpace(width: 8),
                        Text(
                          pan,
                          style: customTextStyle(
                                  fontSize: 12, weight: FontWeight.normal)
                              .copyWith(color: AppColor.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: percentWidth(),
            height: addresses.isEmpty ? 0 : adaptiveHeight(height: 130),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: addresses.length,
              itemBuilder: (context, index) => AddressCard(
                delete: () async {
                  bool res = await controller.deleteCustomerAddress(
                      customerIndex: customerIndex, addressIndex: index);
                  if (!res) {
                    Get.snackbar('Error', 'Can not delete this address');
                  }
                },
                edit: () {
                  controller.editCustomer(index: index);
                  Get.toNamed(AddressScreen.routeName,
                      arguments: {'isEditing': true, 'index': index});
                },
                addressLine1: addresses[index].addressLine1,
                addressLine2: addresses[index].addressLine2 ?? '',
                city: addresses[index].city,
                state: addresses[index].state,
                postalCode: addresses[index].postalCode ?? '',
              ),
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          WidgetStatePropertyAll(AppColor.primary)),
                  child: Text(AppString.edit),
                  onPressed: () {
                    controller.editCustomer(index: customerIndex);
                    Get.toNamed(CustomerScreen.routeName,
                        arguments: {'isEditing': true, 'index': customerIndex});
                  },
                ),
                whiteSpace(width: 10),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColor.error)),
                  child: Text(AppString.delete),
                  onPressed: () {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => confirmCustomerDeletePopUp(
                        context: context,
                        customerController: controller,
                        index: customerIndex,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
