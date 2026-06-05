import 'package:flutter/material.dart';

class FleetDashboardStats extends StatelessWidget {
  /// Theme Rebuild
  const FleetDashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        "title": "Fleet Status",
        "count": "110",
        "subtitle": "Total Vehicles",
        "icon": Icons.directions_car,
      },
      {
        "title": "Availability",
        "count": "30",
        "subtitle": "Ready to drive",
        "icon": Icons.check_circle_outline,
      },
      {
        "title": "Maintenance",
        "count": "10",
        "subtitle": "Cars Scheduled",
        "icon": Icons.build_outlined,
      },
      {
        "title": "On Road",
        "count": "70",
        "subtitle": "Active Leases",
        "icon": Icons.description_outlined,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.8,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) =>
              _buildStatCard(context, stats[index]),
        );
      },
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> data) {
    /// theme status
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        final Color backgroundColor = isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white;
        final Color textColor = isDark ? Colors.white : Colors.black87;
        final Color subTextColor = isDark
            ? Colors.grey[400]!
            : Colors.grey[600]!;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  data['icon'],
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['title'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: subTextColor,
                      ),
                    ),
                    Text(
                      data['count'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      data['subtitle'],
                      style: TextStyle(fontSize: 11, color: subTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
