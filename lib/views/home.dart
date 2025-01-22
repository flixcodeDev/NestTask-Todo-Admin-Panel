import 'package:flutter/material.dart';
import 'package:nesttask/views/dashboard/admin_dashboard.dart';
import 'package:nesttask/views/create_task.dart';
import 'package:nesttask/views/task_management.dart';

import '../config/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List screens = [
    AdminDashboardScreen(),
    TaskManagementScreen(),
    CreateTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens.elementAt(index),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (val) {
            index = val;
            setState(() {});
          },
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.greyColor,
          backgroundColor: AppColors.whiteColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Upcoming'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ));
  }
}
