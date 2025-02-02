import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesttask/views/bottomNav/bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
      url: "https://yynhcurogtvlyxlvwdxp.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5bmhjdXJvZ3R2bHl4bHZ3ZHhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI5NjYxMDksImV4cCI6MjAzODU0MjEwOX0.l0evERrWy1wSnvH-0elVPHJmGOjIG0xHDXFQKOltNu0");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NestTask-TODO-Admin Panel',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const BottomNav(),
    );
  }
}
