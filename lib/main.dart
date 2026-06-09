import 'package:flutter/material.dart';
import 'package:gulfdrive/screens/splash_screen.dart';
import 'package:gulfdrive/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase কনফিগ
const String supabaseUrl = 'https://hmvcvwayuritvdpwvcby.supabase.co';
const String supabaseAnonKey = 'sb_publishable_sDRMchk9eMxXNcrU2xL0DA_9ODKdutp';

/// থিম হ্যান্ডেল করার জন্য গ্লোবাল নটিফায়ার
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase ইনিশিয়ালাইজ
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  /// final supabaseService = SupabaseService();
  /// await supabaseService.seedDatabase();

  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GulfDrive',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const SplashScreen(),
        );
      },
    );
  }
}

/// থিম পরিবর্তন করার ফাংশন (যেখানে সুইচ বাটন আছে সেখানে এটি কল করবে)
Future<void> toggleTheme(bool isDark) async {
  themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', isDark);
}
