import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class TabWidget extends StatelessWidget {
  final String title;
  bool isActive = false;
  TabWidget({super.key, this.isActive = false, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      margin: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.whiteColor : AppColors.secondaryWhiteColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.blackColor : AppColors.blackColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
