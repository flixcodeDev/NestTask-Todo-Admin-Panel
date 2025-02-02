import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nesttask/config/app_colors.dart';
import 'package:nesttask/services/update_task_service.dart';

class UpdateTask extends StatefulWidget {
  Map<String, dynamic> data;
  UpdateTask({super.key, required this.data});

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTask> {
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final updateTaskService = Get.put(UpdateTaskService());

  DateTime? _selectedDate;
  final List<String> _categories = [
    'Presentation',
    'Quiz',
    'Assignment',
    'Lab Report',
    'Lab Final',
    'Task',
    'Project Report',
    'Others'
  ];
  String? _selectedCategory;

  void _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDateController.text.isNotEmpty
          ? DateTime.parse(widget.data["start_date"])
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _startDateController.text =
            DateFormat('MMM d, yyyy').format(pickedDate);
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDateController.text.isNotEmpty
          ? DateTime.parse(widget.data["end_date"])
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _endDateController.text = DateFormat('MMM d, yyyy').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    _selectedCategory = widget.data["category"];
    // Initialize controllers with existing data
    _courseTitleController.text = widget.data["title"] ?? '';
    _descriptionController.text = widget.data["content"] ?? '';

    // Initialize date controllers if data exists
    _startDateController.text = widget.data["start_date"] != null
        ? DateFormat('MMM d, yyyy')
            .format(DateTime.parse(widget.data["start_date"]))
        : '';

    _endDateController.text = widget.data["end_date"] != null
        ? DateFormat('MMM d, yyyy')
            .format(DateTime.parse(widget.data["end_date"]))
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("This is my editable data: ${widget.data["content"]}");

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.linearPrimaryColor,
              AppColors.linearSecondaryColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      )),
                ],
              ),
              // Course Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                  controller: _courseTitleController
                    ..text = widget.data["title"] ?? '',
                  decoration: InputDecoration(
                      labelText: 'Edit Name',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.whiteColor),
                      hintText: 'Edit course title',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: 16),

              // Start Date Picker
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                  controller: _startDateController,
                  readOnly: true,
                  onTap: () => _selectStartDate(context),
                  decoration: InputDecoration(
                    labelText: 'Edit Start Date',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.whiteColor),
                    hintText: 'Select date',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //End Date Picker
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                  controller: _endDateController,
                  readOnly: true,
                  onTap: () => _selectEndDate(context),
                  decoration: InputDecoration(
                    labelText: 'Edit End Date',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.whiteColor),
                    hintText: 'Select date',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      // Description
                      TextField(
                        controller: _descriptionController
                          ..text = widget.data["content"] ?? '',
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Edit Description',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Write your task description here...',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Category Tags
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categories.map((category) {
                          final isSelected = _selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.purple
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.grey.shade400,
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Create Task Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () async {
                            await updateTaskService.updateTask(
                              widget.data["id"], // Pass the task ID
                              _courseTitleController.text,
                              _descriptionController.text,
                              _startDateController.text,
                              _endDateController.text,
                              _selectedCategory ?? widget.data["category"],
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Edit Task',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
