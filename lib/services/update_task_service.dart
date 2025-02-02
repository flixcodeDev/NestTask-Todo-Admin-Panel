import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nesttask/views/bottomNav/bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateTaskService {
  Future<void> updateTask(String taskId, String title, String content,
      startDate, endDate, category) async {
    final supabase = Supabase.instance.client;

    String convertToYYYYMMDD(String inputDate) {
      DateTime date = DateFormat("MMM d, yyyy").parse(inputDate);
      return DateFormat("yyyy-MM-dd").format(date);
    }

    try {
      final response = await supabase
          .from('notes')
          .update({
            'title': title,
            'content': content,
            'start_date': convertToYYYYMMDD(startDate),
            'end_date': convertToYYYYMMDD(endDate),
            'category': category,
          })
          .eq('id', taskId)
          .select(); // Ensure data is returned

      //  print(response); // Debugging

      if (response.isEmpty) {
        Get.snackbar('Error', 'Task not found or not updated',
            backgroundColor: Colors.red);
      } else {
        Get.to(const BottomNav());
        Get.snackbar('Success', 'Task updated successfully',
            backgroundColor: Colors.green);
      }
    } on SocketException {
      Get.snackbar("Network Error", "No Internet Connection",
          backgroundColor: Colors.red);
    } on TimeoutException {
      Get.snackbar("Timeout", "Request Timed Out", backgroundColor: Colors.red);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again later.',
          backgroundColor: Colors.red);
    }
  }
}
