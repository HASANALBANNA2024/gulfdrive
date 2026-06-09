import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/car_details_screen.dart';

class GlobalSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> allCars;

  GlobalSearchDelegate(this.allCars);

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
    /// Search Logic
    final results = allCars.where((car) {
      final q = query.toLowerCase();

      // এখানে সব প্যারামিটার একসাথে চেক করা হচ্ছে
      final name = (car['name']?.toString() ?? '').toLowerCase();
      final brand = (car['brand']?.toString() ?? '').toLowerCase();
      final category = (car['category']?.toString() ?? '').toLowerCase();
      final transmission = (car['transmission']?.toString() ?? '')
          .toLowerCase();
      final fuelType = (car['fuel_type']?.toString() ?? '').toLowerCase();
      final engine = (car['engine_type']?.toString() ?? '').toLowerCase();

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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              car['image_url'] ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.directions_car),
            ),
          ),
          title: Text(car['name'] ?? 'Unknown Car'),
          subtitle: Text(
            "${car['brand']} • ${car['transmission']} • ${car['fuel_type']}",
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
    // সার্চ করার সময় সাজেশন দেখানোর জন্য (ঐচ্ছিক)
    return const Center(child: Text("Search by name, brand, or features..."));
  }
}
