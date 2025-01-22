import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesttask/config/app_colors.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('MMM d, yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _courseTitleController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.whiteColor),
                      hintText: 'Enter course title',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: 16),

              // Date Picker
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    labelText: 'Date',
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
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Write your task description here...',
                        ),
                      ),
                      SizedBox(height: 16),

                      // Category Tags
                      Text(
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
                              padding: EdgeInsets.symmetric(
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
                          onPressed: () {
                            if (_courseTitleController.text.isNotEmpty &&
                                _dateController.text.isNotEmpty &&
                                _selectedCategory != null) {
                              print('Task Created!');
                              print('Name: ${_courseTitleController.text}');
                              print('Date: ${_dateController.text}');
                              print(
                                  'Description: ${_descriptionController.text}');
                              print('Category: $_selectedCategory');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Create Task',
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
