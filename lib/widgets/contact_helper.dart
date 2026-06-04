import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactHelper {
  static Future<void> launchCall(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static void showContactDialog(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const ContactContent(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: const SizedBox(width: 400, child: ContactContent()),
        ),
      );
    }
  }
}

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Contact For Inquiry",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 15),

          _buildItem(
            context,
            Icons.phone,
            "Call Us",
            () => ContactHelper.launchCall("+8801XXXXXXXXX"),
          ),
          _buildItem(
            context,
            Icons.message,
            "WhatsApp",
            () => ContactHelper.launchURL("https://wa.me/8801XXXXXXXXX"),
          ),
          _buildItem(
            context,
            Icons.facebook,
            "Messenger",
            () => ContactHelper.launchURL("https://m.me/YourPageName"),
          ),
          _buildItem(
            context,
            Icons.email,
            "Email",
            () => ContactHelper.launchURL("mailto:support@gulfdrive.com"),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }
}
