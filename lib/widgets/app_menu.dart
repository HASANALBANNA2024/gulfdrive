import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/contact_us_page.dart';
import 'package:gulfdrive/widgets/faq_page.dart';
import 'package:gulfdrive/widgets/services_screen.dart';
import 'package:gulfdrive/widgets/terms_conditions_page.dart';

import '../abouts/about_screen.dart';
import '../theme/app_theme.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage('assets/images/background_header.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black45,
                BlendMode.darken,
              ), // ইমেজটা একটু ডার্ক করলে টেক্সট ভালো ফুটে উঠবে
            ),
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // টেক্সট একদম নিচে চলে যাবে
            crossAxisAlignment: CrossAxisAlignment.start, // বাম দিকে থাকবে
            children: [
              Text(
                'GulfDrive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your Travel Partner',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),

        _buildListTile(context, "Dashboard", Icons.dashboard, () {}),

        _buildListTile(context, "Services", Icons.directions_car, () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => const ServicesScreen()),
          );
        }),

        _buildListTile(context, "Fleet Services", Icons.directions_car, () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const FleetPage()));
        }),

        ExpansionTile(
          leading: const Icon(Icons.business),
          title: const Text("Company Info"),
          children: [
            _buildSubMenu(context, "About Us", () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            }),
            _buildSubMenu(context, "Terms & Conditions", () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => const TermsConditionsPage(),
                ),
              );
            }),
          ],
        ),

        _buildListTile(context, "Pricing", Icons.price_change, () {}),

        _buildListTile(context, "Contact", Icons.contact_mail, () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => const ContactUsPage()),
          );
        }),

        _buildListTile(context, "FAQ", Icons.question_answer, () {
          Navigator.of(
            context,
            rootNavigator: true,
          ).push(MaterialPageRoute(builder: (context) => const FAQPage()));
        }),

        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, mode, __) {
            return SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              value: mode == ThemeMode.dark,
              onChanged: (val) =>
                  themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
            );
          },
        ),

        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Version 1.0.0+1",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  /// মেনু আইটেম নেভিগেশন হ্যান্ডলার
  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        // ছোট স্ক্রিনে ড্রয়ার ক্লোজ হওয়া নিশ্চিত করার জন্য ডিলে
        if (MediaQuery.of(context).size.width < 900) {
          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 250));
        }
        onTap();
      },
    );
  }

  /// সাব-মেনু আইটেম নেভিগেশন হ্যান্ডলার
  Widget _buildSubMenu(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 50),
      title: Text(title),
      onTap: () async {
        if (MediaQuery.of(context).size.width < 900) {
          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 250));
        }
        onTap();
      },
    );
  }
}
