import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/responsive_extension.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        "title": "Hourly Rental",
        "desc":
            "Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour. Ideal for short city trips, quick errands, or business meetings.",
        "features": [
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
          "Flexible Timing",
          "Quick Booking",
        ],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Daily Rental",
        "desc": "Perfect for full-day travel requirements.",
        "features": ["24 Hours Access", "Insurance Included"],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Hourly Rental",
        "desc":
            "Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour. Ideal for short city trips, quick errands, or business meetings.",
        "features": [
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
          "Flexible Timing",
          "Quick Booking",
        ],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Daily Rental",
        "desc": "Perfect for full-day travel requirements.",
        "features": ["24 Hours Access", "Insurance Included"],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Hourly Rental",
        "desc":
            "Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour. Ideal for short city trips, quick errands, or business meetings.",
        "features": [
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
          "Flexible Timing",
          "Quick Booking",
        ],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Daily Rental",
        "desc": "Perfect for full-day travel requirements.",
        "features": ["24 Hours Access", "Insurance Included"],
        "image": "assets/images/background_header.jpg",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth >= 1100)
            ? 3
            : (constraints.maxWidth >= 600)
            ? 2
            : 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: _buildAdaptiveGrid(services, crossAxisCount, context),
            ),
          ),
        );
      },
    ).toResponsiveScaffold(context, "Our Services");
  }

  Widget _buildAdaptiveGrid(
    List<Map<String, dynamic>> services,
    int crossAxisCount,
    BuildContext context,
  ) {
    List<Widget> rows = [];
    for (int i = 0; i < services.length; i += crossAxisCount) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < crossAxisCount; j++) {
        if (i + j < services.length) {
          rowChildren.add(
            Expanded(child: _buildServiceCard(context, services[i + j])),
          );
          if (j < crossAxisCount - 1) {
            rowChildren.add(const SizedBox(width: 20));
          }
        } else {
          rowChildren.add(const Expanded(child: SizedBox()));
        }
      }
      rows.add(
        IntrinsicHeight(
          /// IntrinsicHeight all size of card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowChildren,
          ),
        ),
      );
      rows.add(const SizedBox(height: 20));
    }
    return Column(children: rows);
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              service['image'],
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            service['title'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            service['desc'],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const Spacer(),
          const SizedBox(height: 16),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: (service['features'] as List<String>)
                .map(
                  (f) => Chip(
                    label: Text(f, style: const TextStyle(fontSize: 11)),
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.05),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
