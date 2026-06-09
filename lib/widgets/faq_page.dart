import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/responsive_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  /// panel open track
  int? _expandedIndex;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Map<String, List<Map<String, String>>> faqData = {
      "General": [
        {
          "q": "What is GulfDrive?",
          "a":
              "GulfDrive is a premium transportation solution provider established in 2026, focusing on safe and reliable travel.",
        },
      ],
      "Booking & Drivers": [
        {
          "q": "Can I choose my driver?",
          "a":
              "Currently, our system automatically assigns the best available driver nearby to ensure your ride is confirmed quickly.",
        },
        {
          "q": "How do I know my driver is safe?",
          "a":
              "All our drivers are professionally verified, background-checked, and trained to maintain the highest standards of safety and hygiene.",
        },
        {
          "q": "What if I cannot find a driver?",
          "a":
              "In rare cases, if no drivers are available, please wait a moment or contact our support team, and we will assist you immediately.",
        },
        {
          "q": "Can I pre-book my ride?",
          "a":
              "Yes, our upcoming version will support scheduled bookings, allowing you to book your driver in advance.",
        },
      ],
    };

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...faqData.entries.map(
              (category) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      category.key.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  ...category.value.map((item) {
                    int index =
                        faqData.values.toList().indexOf(category.value) * 10 +
                        category.value.indexOf(item);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        key: Key(index.toString()),
                        initiallyExpanded: index == _expandedIndex,
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            _expandedIndex = isExpanded ? index : null;
                          });
                        },
                        title: Text(
                          item["q"]!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              item["a"]!,
                              style: TextStyle(
                                height: 1.6,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Still need help?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _buildSupportButton(
                  Icons.call,
                  "Call",
                  () => _launchUrl("tel:+8801234567890"),
                ),
                _buildSupportButton(
                  Icons.message,
                  "WhatsApp",
                  () => _launchUrl("https://wa.me/8801234567890"),
                ),
                _buildSupportButton(
                  Icons.email,
                  "Email",
                  () => _launchUrl("mailto:support@gulfdrive.com"),
                ),
                _buildSupportButton(
                  Icons.location_on,
                  "Office",
                  () => _launchUrl(
                    "https://www.google.com/maps/search/?api=1&query=Uttara+Sector+10+Dhaka",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ).toResponsiveScaffold(context, "Help Center & FAQs");
  }

  Widget _buildSupportButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
