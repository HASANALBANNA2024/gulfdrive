import 'package:flutter/material.dart';
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
              opacity: 0.9,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                'GulfDrive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        /// direct navigation
        _buildListTile(context, "Dashboard", Icons.dashboard, () {}),
        _buildListTile(context, "Fleet Catalog", Icons.directions_car, () {
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
        _buildListTile(context, "Support", Icons.support_agent, () {}),
        _buildListTile(context, "Contact", Icons.contact_mail, () {}),
        _buildListTile(context, "FAQ", Icons.question_answer, () {}),
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
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Version 1.0.0+1",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// simple menu item
  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        onTap();

        ///call back run
        if (MediaQuery.of(context).size.width < 900) Navigator.pop(context);
      },
    );
  }

  /// simple sub menu item
  Widget _buildSubMenu(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 50),
      title: Text(title),
      onTap: () async {
        if (MediaQuery.of(context).size.width < 900) {
          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 200));
        }
        onTap();
      },
    );
  }
}
