import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controller/customer_controller.dart';
import '../../../../core/exports.dart';
import '../../../../models/pan_model.dart';
import '../../error/error_screen.dart';

class PanInput extends StatefulWidget {
  final TextEditingController controller;
  const PanInput({super.key, required this.controller});

  @override
  State<PanInput> createState() => _PanInputState();
}

class _PanInputState extends State<PanInput> {
  bool isDisabled = false;
  bool isLoading = false;
  bool isSuccess = false;
  final CustomerController _customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(10), // Set max length here
        ],
        enabled: !isDisabled,
        decoration: InputDecoration(
          labelText: AppString.pan,
          border: isSuccess
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.success),
                )
              : const OutlineInputBorder(),
          suffixIcon: isSuccess
              ? Icon(
                  Icons.done,
                  color: AppColor.success,
                )
              : isLoading
                  ? Container(
                      height: 10,
                      width: 10,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
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
            isSuccess = false;
            isLoading = false;
          });
          if (value.length == 10) {
            //disable
            setState(() {
              isDisabled = true;
              isLoading = true;
            });

            //call api

            PanModel pan = PanModel(
                panNumber: kDebugMode ? 'AAFNZ2078H' : widget.controller.text);
            try {
              setState(() {
                isLoading = true;
              });
              bool res = await _customerController.panValidation(pan: pan);
              setState(() {
                isSuccess = res;
                isDisabled = false;
              });
            } catch (e) {
              Log.e(msg: '$e');
              Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
              isSuccess = false;
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 10) {
            return AppString.panError;
          }
          return null;
        },
      ),
    );
  }
}
