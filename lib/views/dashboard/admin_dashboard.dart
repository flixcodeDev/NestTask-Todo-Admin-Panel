import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nesttask/utils/date_formation.dart';
import 'package:nesttask/views/dashboard/widgets/container_widget.dart';
import 'package:nesttask/views/dashboard/widgets/tab_widget.dart';
import 'package:nesttask/widgets/custom_card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/app_colors.dart';

class AdminDashboardScreen extends StatefulWidget {
  AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final dateFormation = DateFormation();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section

              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.00, top: 60.00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Nehal!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text('Admin of 63-G',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 25),
                  ],
                ),
              ),

              // Tabs Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabWidget(
                    isActive: true,
                    title: 'My Tasks',
                  ),
                  TabWidget(
                    isActive: true,
                    title: 'In-progress',
                  ),
                  TabWidget(
                    isActive: true,
                    title: 'Completed',
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Cards Section
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ContainerWidget(
                        title: 'Total Student Enrolled',
                        count: '13',
                        date: 'October 20, 2020',
                        icon: Icons.person,
                        context: context);
                  },
                ),
              ),
              const SizedBox(height: 30),

              // All Tasks Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.00),
                child: Text('All Tasks',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Map<String, dynamic>>>(
                  stream: supabase.from("notes").stream(primaryKey: ['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No todos found!'));
                    }

                    final todos = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15.00),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        final startDate =
                            dateFormation.listTileDate(todo["start_date"]);
                        final endDate =
                            dateFormation.listTileDate(todo["end_date"]);
                        print(todo["id"]);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: CustomCardWidget(
                            title: todo["title"],
                            date: '$startDate - $endDate',
                            icon: Icons.calendar_today,
                            context: context,
                            taskId: todo["id"],
                            data: todo,
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
