import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final String count;
  final String date;
  final IconData icon;
  final BuildContext context;
  const ContainerWidget({
    super.key,
    required this.title,
    required this.count,
    required this.date,
    required this.icon,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5),
      padding: const EdgeInsets.all(16),
      width: 240,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/card.png'),
          fit: BoxFit.cover, // Ensures the image fills the container
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage('assets/icons/vc.png')),
                      ),
                      child: Icon(icon, color: Colors.white, size: 32)),
                  const SizedBox(width: 8),
                  Text(
                    "Users",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.whiteColor, fontSize: 26),
          ),
          Divider(color: Colors.white),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(color: Colors.grey[200]),
          ),
        ],
      ),
    );
  }
}
