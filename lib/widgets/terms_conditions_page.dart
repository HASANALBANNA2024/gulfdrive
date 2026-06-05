import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    /// text colour set of according to theme card
    final textColor = isDarkMode ? Colors.grey[300] : Colors.grey[800];
    final titleColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Last Updated: June 05, 2026",
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 25),

              _buildSection(
                "1. Acceptance of Terms",
                "By accessing or using the GulfDrive app, you agree to be bound by these Terms and Conditions. If you do not agree, you must not use our services.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "2. User Accounts",
                "You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "3. Service Usage",
                "Our services are for personal, non-commercial use. We reserve the right to refuse service, terminate accounts, or cancel bookings at our discretion.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "4. Payments & Refunds",
                "All payments must be made through our authorized gateways. Refund requests are subject to our service-specific refund policy as detailed in the app.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "5. Data Privacy",
                "Your privacy is important to us. We collect and process personal data in accordance with our Privacy Policy, ensuring your information is handled securely.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "6. Limitation of Liability",
                "GulfDrive shall not be held liable for any indirect, incidental, or consequential damages resulting from the use or inability to use our services.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "7. Governing Law",
                "These terms shall be governed by and construed in accordance with the laws of Bangladesh, without regard to its conflict of law provisions.",
                textColor,
                titleColor,
              ),
              _buildSection(
                "8. Modification of Terms",
                "We reserve the right to update or modify these terms at any time. Continued use of the app after such changes constitutes your acceptance of the new terms.",
                textColor,
                titleColor,
              ),

              const Divider(height: 40),
              Text(
                "Need help?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "If you have any questions, please contact our support team at support@gulfdrive.com",
                style: TextStyle(fontStyle: FontStyle.italic, color: textColor),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    Color? textColor,
    Color? titleColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 15, height: 1.5, color: textColor),
          ),
        ],
      ),
    );
  }
}
