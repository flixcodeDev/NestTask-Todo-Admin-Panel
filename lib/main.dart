import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesttask/config/app_colors.dart';
import 'package:nesttask/config/app_images.dart';
import 'package:nesttask/views/dashboard/admin_dashboard.dart';
import 'package:nesttask/views/home.dart';
import 'package:table_calendar/table_calendar.dart';

import 'config/app_theme.dart';
import 'views/create_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NestTask-TODO-Admin Panel',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
