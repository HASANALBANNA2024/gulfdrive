import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          /// image area
          Expanded(
            flex: 5,
            child: Image.network(
              car['image_url'] ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stack) =>
                  const Center(child: Icon(Icons.directions_car, size: 40)),
            ),
          ),

          /// Text and area section
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Text Section
                  Text(
                    car['name'] ?? 'Car Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${car['base_price'] ?? '0'}/day",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        /// navigation logic
                      },
                      child: const Text(
                        "Call for Inquiry",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        /// Navigation Logic
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
