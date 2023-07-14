import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CardDecorations {
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: AppColors.whiteBackgroundColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 5),
          blurRadius: 5.0,
        ),
      ],
    );
  }

  static TextStyle titleCardTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      color: AppColors.blackTextColor,
    );
  }

  static TextStyle subtitleCardTextStyle() {
    return const TextStyle(
      fontSize: 15,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      color: AppColors.greyTextColor,
    );
  }

  static TextStyle detailProductTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      color: AppColors.blackTextColor,
    );
  }

  static TextStyle detailProductDescriptionTextStyle() {
    return const TextStyle(
      fontSize: 14,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      color: AppColors.greyTextColor,
    );
  }

  static TextStyle detailProductPriceTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w500,
      color: AppColors.blackTextColor,
    );
  }
}
