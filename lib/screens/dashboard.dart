import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/car_card.dart';
import 'package:gulfdrive/widgets/custom_app_bar.dart';

import '../stats/fleet_dashboard_stats.dart';
import '../widgets/app_menu.dart';

class Dashboard extends StatelessWidget {
  final Map<String, dynamic> data;
  const Dashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List cars = data['cars'] ?? [];
    final bool isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      /// mobile drawer open and desktop null
      drawer: isDesktop ? null : const Drawer(child: AppMenu()),
      appBar: const CustomAppBar(title: "GulfDrive"),

      ///sidebar logic for web and desktop
      body: Row(
        children: [
          /// desktop view sidebar
          if (isDesktop)
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                  right: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: const AppMenu(),
            ),

          ///stats
          const SizedBox(height: 20),

          /// main content
          /// main content
          Expanded(
            child: Center(
              // কার্ডগুলোকে স্ক্রিনের মাঝখানে রাখার জন্য
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1100,
                ), // এখানেই 1100px লিমিট করা
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      const FleetDashboardStats(), // কার্ডগুলো এখানে সুন্দরভাবে মাঝখানে থাকবে
                      const SizedBox(height: 20),

                      /// Car Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth > 1000
                              ? 4
                              : (constraints.maxWidth > 600 ? 2 : 1);
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: (constraints.maxWidth < 600)
                                      ? 0.9
                                      : 0.85,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              return CarCard(car: cars[index]);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
