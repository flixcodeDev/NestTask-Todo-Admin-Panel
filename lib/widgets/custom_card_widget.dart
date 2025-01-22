import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import '../config/app_colors.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final BuildContext context;
  const CustomCardWidget({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.00, vertical: 9.00),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [
              AppColors.linearPrimaryColor,
              AppColors.linearSecondaryColor
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Icon(icon, color: AppColors.whiteColor, size: 32),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        subtitle: Text(
          date,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.greyColor, fontWeight: FontWeight.w400),
        ),
        trailing: Builder(builder: (context) {
          return IconButton(
              onPressed: () async {
                await showPopover(
                    context: context,
                    bodyBuilder: (context) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Edit",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Delete",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    width: 115,
                    height: 85,
                    backgroundColor: AppColors.whiteColor,
                    direction: PopoverDirection.bottom);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ));
        }),
      ),
    );
  }
}
