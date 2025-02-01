import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateTaskService {
  Future<void> createTask(
      {context, title, course, startDate, endDate, category}) async {
    try {
      if (course.isNotEmpty &&
          startDate.isNotEmpty &&
          endDate.isNotEmpty &&
          category != null &&
          title.isNotEmpty) {
        await Supabase.instance.client.from('notes').insert({
          'title': title,
          'content': course,
          'start_date': startDate,
          'end_date': endDate,
          "category": category
        });
        Get.snackbar("Success", "Task Created Successfully!",
            backgroundColor: Colors.green);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields'),
          ),
        );
      }
    } on SocketException {
      Get.snackbar("Network Error", "No Internet Connection",
          backgroundColor: Colors.red);
    } on TimeoutException {
      Get.snackbar("Timeout", "Request Timed Out", backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar("Error", "Something Went Wrong",
          backgroundColor: Colors.red);
      debugPrint("Error: $e");
    }
  }
}
