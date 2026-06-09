import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/car_details_screen.dart';

import 'car_data_provider.dart';

class GlobalSearchDelegate extends SearchDelegate {
  GlobalSearchDelegate();

  /// dark and light mode
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.5)),
        border: InputBorder.none,
      ),
    );
  }

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

  /// common result filter logic
  List<Map<String, dynamic>> _getFilteredResults() {
    final q = query.toLowerCase();
    return CarDataProvider.allCars.where((car) {
      String name = (car['name'] ?? '').toString().toLowerCase();
      String brand = (car['brand'] ?? '').toString().toLowerCase();
      String category = (car['category'] ?? '').toString().toLowerCase();
      return name.contains(q) || brand.contains(q) || category.contains(q);
    }).toList();
  }

  /// no enter click
  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultsList(_getFilteredResults());
  }

  /// enter click result
  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsList(_getFilteredResults());
  }

  /// common list builder
  Widget _buildResultsList(List<Map<String, dynamic>> results) {
    if (results.isEmpty) {
      return const Center(child: Text("No cars found."));
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final car = results[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    car['image_url'] ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.directions_car),
                  ),
                ),
                title: Text(
                  car['name'] ?? 'Unknown',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${car['brand'] ?? ''} • ${car['transmission'] ?? 'N/A'} • ${car['fuel_type'] ?? ''}",
                ),
                onTap: () {
                  close(context, null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarDetailsScreen(car: car),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
