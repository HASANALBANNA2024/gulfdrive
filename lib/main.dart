import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/splash_screen.dart';
import 'package:gulfdrive/theme/app_theme.dart'; // আপনার নতুন থিম ফাইলটি ইমপোর্ট করুন
import 'package:supabase_flutter/supabase_flutter.dart';

/// supabase url and anon key
const String supabaseUrl = 'https://hmvcvwayuritvdpwvcby.supabase.co';
const String supabaseAnonKey = 'sb_publishable_sDRMchk9eMxXNcrU2xL0DA_9ODKdutp';

Future<void> main() async {
  /// flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  /// supabase initialized
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  /// await SupabaseService().deleteData('cars', 1);
  /// await SupabaseService().updateData('cars', 2, {'name': 'hondai'});
  /// final data = await SupabaseService().fetchData('cars');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Value Notifier Swithc
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GulfDrive',

          /// Custom Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
