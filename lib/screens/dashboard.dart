import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GulfDrive Home")),
      body: const Center(child: Text("স্বাগতম! এখানে গাড়িগুলো দেখাবে।")),
    );
  }
}
