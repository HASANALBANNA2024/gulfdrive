import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/contact_helper.dart';
import 'package:gulfdrive/widgets/responsive_extension.dart';

class CarDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// features
    List<String> features =
        (car['car_features']?.toString() ??
                'Active Safety,Lane Keeping,Adaptive Cruise Control')
            .split(',');

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image section
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  car['image_url'] ?? '',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/background_header.jpg',
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              /// name and description
              Text(
                car['name'] ?? 'BMW X5',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                car['description'] ??
                    "Luxury, sophisticated, with powerful performance.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              /// specification card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Vehicle Specifications"),
                    const SizedBox(height: 15),
                    _buildCompactRow("Brand Name:", car['brand'] ?? 'N/A'),
                    _buildCompactRow("Category:", car['category'] ?? 'N/A'),
                    _buildCompactRow(
                      "Engine Type:",
                      car['engine_type'] ?? 'N/A',
                    ),
                    _buildCompactRow(
                      "Transmission:",
                      car['transmission'] ?? 'N/A',
                    ),
                    _buildCompactRow("Fuel Type:", car['fuel_type'] ?? 'N/A'),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(),
                    ),

                    // ৪. ফিচার পয়েন্ট (চেক মার্কসহ)
                    _buildSectionHeader("Key Features"),
                    const SizedBox(height: 15),
                    ...features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              f.trim(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// call button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => ContactHelper.showContactDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Call for Inquiry",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).toResponsiveScaffold(context, car['name'] ?? 'Car Details');
  }

  // প্রফেশনাল সেকশন হেডার
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  // প্রফেশনাল ডাটা রো
  Widget _buildCompactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
