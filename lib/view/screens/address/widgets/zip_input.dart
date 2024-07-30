import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../models/postal_model.dart';
import '../../error/error_screen.dart';

class PostalInput extends StatefulWidget {
  final TextEditingController controller;
  const PostalInput({super.key, required this.controller});

  @override
  State<PostalInput> createState() => _PostalInputState();
}

class _PostalInputState extends State<PostalInput> {
  bool isDisabled = false;
  bool isLoading = false;
  final CustomerController _customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(6), // Set max length here
        ],
        keyboardType: TextInputType.number,
        enabled: !isDisabled,
        decoration: InputDecoration(
          labelText: AppString.pinCode,
          border: const OutlineInputBorder(),
          suffixIcon: isLoading
              ? Container(
                  height: 10,
                  width: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primary,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        controller: widget.controller,
        onChanged: (value) async {
          setState(() {
            isLoading = false;
          });
          if (value.length == 6) {
            //disable
            setState(() {
              isDisabled = true;
              isLoading = true;
            });

            //call api

            PostalModel postal = PostalModel(
                postcode:
                    kDebugMode ? 411005 : int.parse(widget.controller.text));
            try {
              setState(() {
                isLoading = true;
              });
              await _customerController.postalValidation(postalBody: postal);
              setState(() {
                isDisabled = false;
              });
            } catch (e) {
              Log.e(msg: '$e');
              Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 6) {
            return AppString.pinCodeError;
          }
          return null;
        },
      ),
    );
  }
}
