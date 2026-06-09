import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/car_details_screen.dart';

import 'car_data_provider.dart';

class GlobalSearchDelegate extends SearchDelegate {
  // কনস্ট্রাক্টর থেকে লিস্ট সরিয়ে দেওয়া হয়েছে
  GlobalSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final q = query.toLowerCase();

    final results = CarDataProvider.allCars.where((car) {
      // এখানে আমরা চেক করছি ডাটা যদি null হয় তবে সেটি খালি স্ট্রিং হিসেবে ধরবে
      String name = (car['name'] ?? '').toString().toLowerCase();
      String brand = (car['brand'] ?? '').toString().toLowerCase();
      String category = (car['category'] ?? '').toString().toLowerCase();
      String transmission = (car['transmission'] ?? '')
          .toString()
          .toLowerCase();
      String fuelType = (car['fuel_type'] ?? '').toString().toLowerCase();
      String engine = (car['engine_type'] ?? '').toString().toLowerCase();

      // এখন যদি ইউজার 'Toyota' লিখে তবে Toyota Corolla চলে আসবে
      return name.contains(q) ||
          brand.contains(q) ||
          category.contains(q) ||
          transmission.contains(q) ||
          fuelType.contains(q) ||
          engine.contains(q);
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text("No cars found matching your search."));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final car = results[index];
        return ListTile(
          title: Text(car['name'] ?? 'Unknown Car'),
          // এখানে NULL চেক করা হয়েছে যাতে ক্র্যাশ না করে
          subtitle: Text(
            "${car['brand'] ?? ''} • ${car['transmission'] ?? 'N/A'}",
          ),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search by name, brand, or features..."));
  }
}
