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
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      drawer: isDesktop ? null : const Drawer(child: AppMenu()),
      appBar: const CustomAppBar(title: "GulfDrive"),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const FleetDashboardStats(),
                      const SizedBox(height: 20),
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
