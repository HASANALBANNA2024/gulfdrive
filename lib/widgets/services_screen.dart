import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        "title": "Hourly Rental",
        "desc":
            "Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour.Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour,Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour,Ideal for short city trips, quick errands, or business meetings. Enjoy flexibility by the hour",
        "features": [
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
        ],
        "image": "assets/images/background_header.jpg",
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
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
        ],
        "image": "assets/images/background_header.jpg",
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
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
        ],
        "image": "assets/images/background_header.jpg",
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
          "Flexible Timing",
          "Quick Booking",
          "City Access",
          "24/7 Support",
        ],
        "image": "assets/images/background_header.jpg",
      },
      {
        "title": "Chauffeur Service",
        "desc":
            "Experience luxury and comfort with our professional, well-trained drivers.",
        "features": [
          "Pro Drivers",
          "Luxury Vehicles",
          "Airport Pickup",
          "Safe Travel",
        ],
        "image": "assets/images/background_header.jpg",
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
        "image": "assets/images/background_header.jpg",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Our Services"), centerTitle: true),
      body: LayoutBuilder(
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
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: services.map((service) {
                    double cardWidth =
                        (constraints.maxWidth / crossAxisCount) - 30;
                    if (constraints.maxWidth < 600)
                      cardWidth = constraints.maxWidth - 32;

                    return SizedBox(
                      width: cardWidth,
                      // IntrinsicHeight প্রতিটি কার্ডকে সারির সবচেয়ে বড় কার্ডের হাইট নিতে সাহায্য করে
                      child: IntrinsicHeight(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  service['image'],
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) => Container(
                                    height: 140,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.directions_car),
                                  ),
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

                              // Spacer কার্ডের ভেতরের বাকি খালি জায়গা দখল করে চিপসকে নিচে নামিয়ে দেবে
                              const Spacer(),

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
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
