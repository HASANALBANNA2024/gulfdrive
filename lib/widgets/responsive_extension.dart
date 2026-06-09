import 'package:flutter/material.dart';

import 'app_menu.dart';
import 'custom_app_bar.dart';

extension ResponsiveScaffold on Widget {
  Widget toResponsiveScaffold(BuildContext context, String title) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      drawer: isDesktop ? null : const Drawer(child: AppMenu()),
      appBar: CustomAppBar(title: title),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                  right: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: const AppMenu(),
            ),
          Expanded(child: this), // 'this' means the widget you called this on
        ],
      ),
    );
  }
}
