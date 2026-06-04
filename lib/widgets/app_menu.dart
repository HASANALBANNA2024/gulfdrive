import 'package:flutter/material.dart';

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
        _buildListTile(context, "Dashboard", Icons.dashboard, () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
        }),
        _buildListTile(context, "Fleet Catalog", Icons.directions_car, () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const FleetPage()));
        }),

        ExpansionTile(
          leading: const Icon(Icons.business),
          title: const Text("Company Info"),
          children: [
            _buildSubMenu(context, "About Us", () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            }),
            _buildSubMenu(context, "Terms & Conditions", () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsPage()));
            }),
          ],
        ),
        _buildListTile(context, "Pricing", Icons.price_change, () {}),
        _buildListTile(context, "Support", Icons.support_agent, () {}),
        _buildListTile(context, "Contact", Icons.contact_mail, () {}),
        _buildListTile(context, "FAQ", Icons.question_answer, () {}),
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
      onTap: () {
        onTap();
        if (MediaQuery.of(context).size.width < 900) Navigator.pop(context);
      },
    );
  }
}
