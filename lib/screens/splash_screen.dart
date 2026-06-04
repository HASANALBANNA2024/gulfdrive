import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/dashboard.dart';

import '../database_service/supabase_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      /// data fetching
      final allData = await SupabaseService().initializeAllData();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard(data: allData)),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // প্রিমিয়াম ডার্ক গ্র্যাডিয়েন্ট
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// car logo
              const Icon(
                Icons.directions_car_filled_rounded,
                size: 100,
                color: Color(0xFF40C4FF),
              ),
              const SizedBox(height: 30),

              /// app title
              const Text(
                "GulfDrive",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Your Journey, Redefined.",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 50),

              /// Loading Indicator
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Loading Database...",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
