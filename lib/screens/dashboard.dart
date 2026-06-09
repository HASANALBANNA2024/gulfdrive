import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/car_card.dart';
import 'package:gulfdrive/widgets/custom_app_bar.dart';

import '../search_delegate/car_data_provider.dart';
import '../stats/fleet_dashboard_stats.dart';
import '../widgets/app_menu.dart';

class Dashboard extends StatefulWidget {
  final Map<String, dynamic> data;
  const Dashboard({super.key, required this.data});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List cars = widget.data['cars'] ?? [];
      CarDataProvider.allCars = List<Map<String, dynamic>>.from(cars);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List cars = widget.data['cars'] ?? [];
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      drawer: isDesktop ? null : const Drawer(child: AppMenu()),
      appBar: const CustomAppBar(title: "Gulf Drive"),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      const FleetDashboardStats(),
                      const SizedBox(height: 20),

                      /// UI সব আগের মতোই আছে
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;

                          double cardWidth;
                          if (totalWidth >= 1100) {
                            cardWidth = (totalWidth / 4) - 16;
                          } else if (totalWidth >= 800) {
                            cardWidth = (totalWidth / 3) - 16;
                          } else if (totalWidth >= 500) {
                            cardWidth = (totalWidth / 2) - 16;
                          } else {
                            cardWidth = totalWidth;
                          }

                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: cars.map((car) {
                              return SizedBox(
                                width: cardWidth,
                                child: CarCard(car: car),
                              );
                            }).toList(),
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
