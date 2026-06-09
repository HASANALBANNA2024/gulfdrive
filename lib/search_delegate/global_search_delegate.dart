import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/car_details_screen.dart';

import 'car_data_provider.dart';

class GlobalSearchDelegate extends SearchDelegate {
  GlobalSearchDelegate();

  /// Handle Dark and Light mode themes
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
        filled: true,
        fillColor: theme.brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
      ),
    );
  }

  /// Ensure the text typed by the user is centered
  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 16);

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

  /// Logic: Filters data based on name, brand, or category
  List<Map<String, dynamic>> _getFilteredResults() {
    final q = query.toLowerCase();

    // Check if data exists
    if (CarDataProvider.allCars.isEmpty) return [];

    return CarDataProvider.allCars.where((car) {
      String name = (car['name'] ?? '').toString().toLowerCase();
      String brand = (car['brand'] ?? '').toString().toLowerCase();
      String category = (car['category'] ?? '').toString().toLowerCase();

      return name.contains(q) || brand.contains(q) || category.contains(q);
    }).toList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResultsList(_getFilteredResults());
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsList(_getFilteredResults());
  }

  /// Display list of results
  Widget _buildResultsList(List<Map<String, dynamic>> results) {
    if (results.isEmpty) {
      return const Center(child: Text("No cars found matching your search."));
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
