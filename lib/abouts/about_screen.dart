import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About GulfDrive",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),

          /// listview
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/background_header.jpg',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),

              // Title & Description
              const Text(
                "Welcome to GulfDrive",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "GulfDrive is a leading provider of premium transportation solutions, established in 2026. "
                "We are committed to delivering safe, comfortable, and reliable travel experiences. "
                "Whether for daily commutes or special trips, we bridge the gap between convenience and quality.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 25),
              _buildSection(
                context,
                "Our Mission",
                "To revolutionize the transportation industry by providing top-tier, technology-driven services that ensure customer satisfaction.",
              ),

              const SizedBox(height: 15),
              _buildSection(
                context,
                "Our Vision",
                "To become the most trusted and preferred transportation partner nationwide, known for excellence and innovation.",
              ),

              const SizedBox(height: 25),
              const Text(
                "Why Choose Us?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildBulletPoint("Professional & Highly Trained Drivers"),
              _buildBulletPoint("Modern Fleet with Advanced Safety Features"),
              _buildBulletPoint("24/7 Dedicated Customer Support"),
              _buildBulletPoint("Transparent Pricing with No Hidden Fees"),
              _buildBulletPoint("Seamless Digital Booking Experience"),
              _buildBulletPoint(
                "Regularly Sanitized & Well-Maintained Vehicles",
              ),

              /// footer and list view
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "GulfDrive Solutions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Version 1.0.0 | Established 2026",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
