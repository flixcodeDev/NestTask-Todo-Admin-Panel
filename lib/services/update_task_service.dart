import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateTaskService {
  Future<void> updateTask(
      taskId, title, content, startDate, endDate, category) async {
    final supabase = Supabase.instance.client;
    String convertToYYYYMMDD(String inputDate) {
      DateTime date = DateFormat("MMM d, yyyy").parse(inputDate);
      return DateFormat("yyyy-MM-dd").format(date);
    }

    try {
      final response = await supabase
          .from('notes') // Your table name
          .update({
        'title': title,
        'content': content,
        'start_date': convertToYYYYMMDD(startDate),
        'end_date': convertToYYYYMMDD(endDate),
        'category': category,
      }).eq('id', taskId); // Find the specific task by ID

      print(response);
      if (response == null) {
        Get.snackbar('Error', 'Failed to update task',
            backgroundColor: Colors.red);
      } else {
        Get.snackbar('Success', 'Task updated successfully',
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red);
    }
  }
}
