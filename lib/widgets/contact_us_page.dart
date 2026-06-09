import 'package:flutter/material.dart';
import 'package:gulfdrive/widgets/responsive_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    /// responsive call
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.contact_mail_rounded,
              size: 80,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Get in Touch",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "We are available to assist you with any inquiries.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),

            _buildContactCard(
              Icons.phone_in_talk_rounded,
              "Call Support",
              "+8801234567890",
              () => _launchUrl("tel:+8801234567890"),
              isDarkMode,
            ),
            _buildContactCard(
              Icons.email_rounded,
              "Email Us",
              "support@gulfdrive.com",
              () => _launchUrl("mailto:support@gulfdrive.com"),
              isDarkMode,
            ),
            _buildContactCard(
              Icons.chat_bubble_rounded,
              "WhatsApp",
              "+8801234567890",
              () => _launchUrl("https://wa.me/8801234567890"),
              isDarkMode,
            ),
            _buildContactCard(
              Icons.place_rounded,
              "Office Address",
              "House 12, Road 5, Sector 10, Uttara, Dhaka",
              () => _launchUrl(
                "https://www.google.com/maps/search/?api=1&query=Uttara+Sector+10+Dhaka",
              ),
              isDarkMode,
            ),
            _buildContactCard(
              Icons.schedule_rounded,
              "Business Hours",
              "Sat - Thu: 9:00 AM - 6:00 PM",
              null,
              isDarkMode,
            ),
          ],
        ),
      ),
    ).toResponsiveScaffold(context, "Contact & Support");
  }

  Widget _buildContactCard(
    IconData icon,
    String label,
    String value,
    VoidCallback? onTap,
    bool isDarkMode,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 15),
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blueAccent),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        trailing: onTap != null
            ? Icon(Icons.chevron_right_rounded, color: Colors.blueAccent)
            : null,
        onTap: onTap,
      ),
    );
  }
}
