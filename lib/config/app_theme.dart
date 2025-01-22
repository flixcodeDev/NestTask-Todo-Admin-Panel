import 'package:flutter/material.dart';

import 'app_colors.dart';

//var lightTheme = ThemeData();
var lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 36,
          color: AppColors.secondaryBlackColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontSize: 32,
          color: AppColors.whiteColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
      headlineSmall: TextStyle(
          fontSize: 23,
          color: AppColors.secondaryBlackColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          fontSize: 20,
          color: AppColors.blackColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300),
      labelMedium: TextStyle(
          fontSize: 16,
          color: AppColors.greyColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
      labelSmall: TextStyle(
          fontSize: 14,
          color: AppColors.blackColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300),
    ));
