import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/contact_helper.dart';

import '../screens/car_details_screen.dart';

class CarCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // এটি কার্ডকে কন্টেন্ট অনুযায়ী সাইজ নিতে বাধ্য করবে
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                car['image_url'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.directions_car, size: 50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['name'] ?? 'Car Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                _buildFeatureRow(Icons.settings, car['transmission'] ?? 'N/A'),
                _buildFeatureRow(
                  Icons.event_seat,
                  "${car['seats'] ?? 0} Seats",
                ),
                _buildFeatureRow(
                  Icons.local_gas_station,
                  car['fuel_type'] ?? 'N/A',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () => ContactHelper.showContactDialog(context),
                    child: const Text("Call for Inquiry"),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailsScreen(car: car),
                      ),
                    ),
                    child: const Text("View Details"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
