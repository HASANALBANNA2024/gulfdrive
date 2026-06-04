import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/car_card.dart';
import 'package:gulfdrive/widgets/custom_app_bar.dart';

class Dashboard extends StatelessWidget {
  final Map<String, dynamic> data;

  const Dashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List cars = data['cars'] ?? [];

    return Scaffold(
      appBar: CustomAppBar(title: "GulfDrive"),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              /// mobile and web view
              int crossAxisCount = constraints.maxWidth > 1000
                  ? 4
                  : (constraints.maxWidth > 600 ? 2 : 1);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    // সমাধান: মোবাইল হলে ratio বাড়িয়ে দিন, বড় স্ক্রিনে 0.85 রাখুন
                    childAspectRatio: (constraints.maxWidth < 600) ? 0.9 : 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return CarCard(car: cars[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
