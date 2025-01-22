import 'package:flutter/material.dart';
import 'package:nesttask/views/dashboard/widgets/container_widget.dart';
import 'package:nesttask/views/dashboard/widgets/tab_widget.dart';
import 'package:nesttask/widgets/custom_card_widget.dart';
import '../../config/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

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
                    const EdgeInsets.only(left: 20.0, right: 20.00, top: 20.00),
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

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15.00),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CustomCardWidget(
                      title: 'Data Science Presentation',
                      date: '19, Feb - 28, Feb',
                      icon: Icons.calendar_today,
                      context: context,
                    ),
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
