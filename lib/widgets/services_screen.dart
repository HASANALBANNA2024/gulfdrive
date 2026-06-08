import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// service list
    final List<Map<String, dynamic>> services = [
      {
        "title": "Hourly Rental",
        "desc":
            "Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour.",
        "features": [
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
        ],
      },
      {
        "title": "Daily Rental",
        "desc":
            "Perfect for full-day travel requirements. Reliable car for 24 hours with seamless booking.",
        "features": [
          "24 Hours Access",
          "Insurance Included",
          "Reliable Fleet",
          "Daily Rate",
        ],
      },
      {
        "title": "Weekly Rental",
        "desc":
            "Balance of cost and convenience for one-week travel plans. Unlimited mileage support.",
        "features": [
          "Unlimited Mileage",
          "Roadside Support",
          "Cost Effective",
          "Long-term Discount",
        ],
      },
      {
        "title": "Monthly Rental",
        "desc":
            "Economical choice for long-term needs. Perfect for extended projects with dedicated support.",
        "features": [
          "Maintenance Included",
          "Replacement Car",
          "Best Rates",
          "Priority Service",
        ],
      },
      {
        "title": "Chauffeur Service",
        "desc":
            "Experience luxury and comfort with our professional, well-trained, and courteous drivers.",
        "features": [
          "Pro Drivers",
          "Luxury Vehicles",
          "Airport Pickup",
          "Safe Travel",
        ],
      },
      {
        "title": "Corporate Transport",
        "desc":
            "Reliable transport solutions for your company employees or guests with custom contracts.",
        "features": [
          "Priority Booking",
          "Custom Contracts",
          "Monthly Billing",
          "Dedicated Support",
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Our Services")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Background Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_header.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content Area
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: services.map((service) {
                      return SizedBox(
                        width: 350,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.5),
                              width: 1.5,
                            ), // বর্ডারটি স্পষ্ট করা হয়েছে
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon/Image Placeholder
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(Icons.directions_car, size: 50),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                service['title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                service['desc'],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                alignment: WrapAlignment.center,
                                children: (service['features'] as List<String>)
                                    .map(
                                      (f) => Chip(
                                        label: Text(
                                          f,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        backgroundColor: Theme.of(
                                          context,
                                        ).primaryColor.withOpacity(0.05),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
