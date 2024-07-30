import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customer_controller.dart';
import '../../../core/exports.dart';
import '../../../uiHelper/exports.dart';
import '../../widgets/address_card.dart';
import '../../widgets/app_button.dart';
import 'widgets/city_selector.dart';
import '../../widgets/input.dart';
import 'widgets/state_selector.dart';
import 'widgets/zip_input.dart';
import '../customerList/customer_list.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';

  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final CustomerController _customerController = Get.put(CustomerController());
  bool isEditing = false;
  bool isAddressEditing = false;
  int editingAddressIndex = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Get.arguments != null) {
      isEditing = Get.arguments['isEditing'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(AppString.address),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    width: percentWidth(),
                    height: _customerController.address.isEmpty
                        ? 0
                        : adaptiveHeight(height: 165),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _customerController.address.length,
                      itemBuilder: (context, index) => AddressCard(
                        delete: () {
                          _deleteAddress(index: index);
                        },
                        edit: () {
                          _editTempAddress(index: index);
                          setState(() {
                            isAddressEditing = true;
                          });
                        },
                        addressLine1:
                            _customerController.address[index].addressLine1 ??
                                '',
                        addressLine2:
                            _customerController.address[index].addressLine2 ??
                                '',
                        city: _customerController.address[index].city ?? '',
                        state: _customerController.address[index].state ?? '',
                        postalCode:
                            _customerController.address[index].postalCode ?? '',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address Information',
                        style: customTextStyle(
                                fontSize: 12, weight: FontWeight.bold)
                            .copyWith(color: AppColor.primary),
                      ),
                      TextButton(
                        onPressed: () async {
                          _customerController.address.length == 10
                              ? Get.snackbar(
                                  'Error',
                                  'You already added 10 address',
                                )
                              : await _saveAddress();
                        },
                        child: Text(
                          _customerController.customer.value.address.isEmpty
                              ? 'Save'
                              : isAddressEditing
                                  ? 'Update'
                                  : 'Add new',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColor.white
                        : AppColor.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        controller:
                            _customerController.firstAddressLineController,
                        labelText: AppString.address1,
                        errorMessage: AppString.address1Error,
                        isRequired: true,
                      ),
                      whiteSpace(height: 24),
                      TextInput(
                        controller:
                            _customerController.secondAddressLineController,
                        labelText: AppString.address2,
                        errorMessage: AppString.address2Error,
                        isRequired: false,
                      ),
                      whiteSpace(height: 24),
                      PostalInput(
                        controller: _customerController.postalController,
                      ),
                      whiteSpace(height: 24),
                      CitySelector(),
                      whiteSpace(height: 24),
                      StateSelector()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          height: 60,
          child: Obx(
            () => SizedBox(
              width: percentWidth(),
              child: appButton(
                isLoading: _customerController.isLoading.isTrue,
                fn: () {
                  _saveCustomerInformation();
                },
                name: AppString.next,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveAddress() {
    if (_formKey.currentState!.validate()) {
      isAddressEditing
          ? {
              _customerController.updateTempAddress(index: editingAddressIndex),
              setState(() {
                isAddressEditing = false;
              })
            }
          : _customerController.saveAddress();
    }
  }

  Future _saveCustomerInformation() async {
    if (_customerController.address.isEmpty) {
      Get.snackbar('Error', 'Add address to continue');
      return;
    }

    if (isEditing) {
      bool res = await _customerController.updateCustomerInformation(
          index: Get.arguments['index'] ?? 0);
      if (res) {
        Get.offAllNamed(CustomersScreen.routeName);
        return;
      }
    } else {
      bool res = await _customerController.saveCustomerInformation();
      if (res) {
        Get.offAllNamed(CustomersScreen.routeName);
        return;
      }
    }
  }

  _deleteAddress({required int index}) {
    Log.d(msg: index);

    _customerController.deleteAddressFromTemp(index: index);
  }

  _editTempAddress({required int index}) {
    _customerController.editTempAddress(index: index);
    setState(() {
      isAddressEditing = true;
      editingAddressIndex = index;
    });
  }
}
