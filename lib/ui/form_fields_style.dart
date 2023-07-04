import 'package:easyfact_mobile/constants/constants.dart';
import 'package:flutter/material.dart';

class FormFieldsStyle {
  InputDecoration textFormField({
    required String hintText,
    required String labelText,
  }) {
    return InputDecoration(
      hintText: hintText,
      label: Text(
        labelText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'OpenSans',
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'OpenSans',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.greyTextColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.greyTextColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
