import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/app_colors.dart';

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  final List<DateTime> _dates = [];
  late String _formattedMonthYear;

  // Use a map to store tasks by date
  final Map<DateTime, List<String>> _tasksByDate = {};

  @override
  void initState() {
    super.initState();
    _formattedMonthYear = DateFormat('MMMM, yyyy').format(_currentDate);
    _generateDatesForCurrentMonth();
  }

  void _generateDatesForCurrentMonth() {
    final startDate = DateTime(_currentDate.year, _currentDate.month, 1);
    final endDate = DateTime(_currentDate.year, _currentDate.month + 1, 0);

    _dates.clear();
    for (int i = 0; i < endDate.day; i++) {
      _dates.add(startDate.add(Duration(days: i)));
    }
  }

  void _addTask(String task, DateTime date) {
    setState(() {
      if (!_tasksByDate.containsKey(date)) {
        _tasksByDate[date] = [];
      }
      _tasksByDate[date]!.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksForSelectedDate = _tasksByDate[_selectedDate] ?? [];

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: MediaQuery.of(context).size.height * .33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formattedMonthYear,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.primaryColor),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                      ),
                      onPressed: () => _showAddTaskDialog(),
                      child: Text(
                        "Add Task",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _dates.map((date) {
                      final isSelected = _selectedDate == date;
                      final hasTasks = _tasksByDate[date]?.isNotEmpty ?? false;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 88,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            image: isSelected || hasTasks
                                ? DecorationImage(
                                    image:
                                        AssetImage("assets/images/date_bg.png"))
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(date),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected || hasTasks
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                DateFormat('d').format(date),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected || hasTasks
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: tasksForSelectedDate.isEmpty
                ? Center(
                    child: Text(
                      'No tasks for the selected date.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasksForSelectedDate.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(tasksForSelectedDate[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                tasksForSelectedDate.removeAt(index);
                                if (tasksForSelectedDate.isEmpty) {
                                  _tasksByDate.remove(_selectedDate);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    TextEditingController _taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _taskController,
          decoration: InputDecoration(hintText: 'Enter task description'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_taskController.text.isNotEmpty) {
                _addTask(_taskController.text, _selectedDate);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
