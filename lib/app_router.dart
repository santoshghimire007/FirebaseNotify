// app_router.dart

import 'package:firebase_notify/feature/notification/ui/pages/handle_notification.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String handleNotificationRoute = '/handle_notification';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': // Handle root route
        return MaterialPageRoute(
          builder: (_) => const HandleNotification(), // Default route
        );
      case handleNotificationRoute:
        final notificationId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => const HandleNotification(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Unknown Route: ${settings.name}')),
          ),
        );
    }
  }
}
