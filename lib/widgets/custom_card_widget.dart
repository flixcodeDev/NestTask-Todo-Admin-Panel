import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesttask/services/delete_task_service.dart';
import 'package:nesttask/views/updateTask/update_task.dart';
import 'package:popover/popover.dart';

import '../config/app_colors.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;
  final taskId;
  final BuildContext context;
  Map<String, dynamic> data;
  CustomCardWidget({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.context,
    required this.taskId,
    required this.data,
  });

  final deleteNoteService = Get.put(DeleteTaskService());

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
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(UpdateTask(
                                    data: data,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.edit_outlined,
                                        size: 15,
                                      ),
                                      const SizedBox(
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
                              ),
                              InkWell(
                                onTap: () {
                                  deleteNoteService.deleteNote(taskId);
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
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
                                ),
                              ),
                            ],
                          ),
                        ),
                    width: 115,
                    height: 88,
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
