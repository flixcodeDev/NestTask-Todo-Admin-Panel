import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesttask/config/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeleteTaskService {
  Future<void> deleteNote(String taskID) async {
    final response =
        await Supabase.instance.client.from('notes').delete().eq('id', taskID);

    if (response.error != null) {
      print('Error deleting note: ${response.error!.message}');
      Get.snackbar("Error", "Error deleting note. Please Try again later",
          backgroundColor: Colors.red);
    } else {
      print('Note deleted successfully');
      Get.snackbar("Success", "Note deleted successfully",
          backgroundColor: AppColors.primaryColor);
    }
  }
}
