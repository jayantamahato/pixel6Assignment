import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/exports.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorMessage;
  final bool isRequired;
  const TextInput(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.isRequired,
      required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return TextFormField(
      keyboardType: labelText == AppString.phone ? TextInputType.phone : null,
      controller: controller,
//length
      inputFormatters: labelText == AppString.phone
          ? [
              LengthLimitingTextInputFormatter(10), // Set max length here
            ]
          : labelText == AppString.email
              ? [
                  LengthLimitingTextInputFormatter(150), // Set max length here
                ]
              : null,

      decoration: InputDecoration(
          prefixText: labelText == AppString.phone ? '+91' : '',
          border: const OutlineInputBorder(),
          labelText: labelText),
      validator: (value) {
        if (!isRequired) {
          return null;
        }
        //for all
        if (value == null || value.isEmpty) {
          return 'Required field';
        }
        //full name validation

        if (labelText == AppString.fullName && value.length > 140) {
          return errorMessage;
        }
        //email no validation

        if (labelText == AppString.email && !emailRegExp.hasMatch(value)) {
          return 'Enter a valid email';
        }
        //mobile no validation
        if (labelText == AppString.phone && value.length != 10) {
          return 'Enter a valid phone number';
        }
        return null;
      },
    );
  }
}
