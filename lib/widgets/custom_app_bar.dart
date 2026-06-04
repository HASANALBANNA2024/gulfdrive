import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDarkMode ? null : Colors.white,
      elevation: isDarkMode ? 2 : 4,
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.white : Colors.black87,
      ),
      titleTextStyle: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      leading: MediaQuery.of(context).size.width < 900
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Row(
        children: [
          const Icon(Icons.directions_car, color: Colors.blue),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        /// Search Bar (Responsive)
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = MediaQuery.of(context).size.width;
            bool isMobile = screenWidth < 600;
            if (isMobile) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              );
            } else {
              return Container(
                width: screenWidth * 0.4,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search cars...",
                    prefixIcon: const Icon(Icons.search, size: 20),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              );
            }
          },
        ),

        /// Theme Notifier
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, mode, __) {
            return IconButton(
              icon: Icon(
                mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () => themeNotifier.value = (mode == ThemeMode.light)
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
