import 'package:app_links/app_links.dart';
import 'package:firebase_notify/service/foreground_notification.dart';
import 'package:flutter/material.dart';

Future<void> initUniLinks() async {
  final appLinks = AppLinks();
  // Handle deep links when the app is launched from a terminated state
  try {
    appLinks.getInitialLink().then((link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });
  } catch (e) {
    // Handle errors
    print('Error handling deep link: $e');
  }

  // Handle deep links while the app is running
  appLinks.uriLinkStream.listen((link) {
    _handleDeepLink(link);
  });
}

void _handleDeepLink(Uri uri) {
  if (uri.pathSegments.isNotEmpty &&
      uri.pathSegments.first == 'handle_notification') {
    final notificationId =
        uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
    Navigator.pushNamed(
        navigatorKey.currentState!.context, '/handle_notification',
        arguments: notificationId);
  }
}

String extractNotificationId(String url) {
  final uri = Uri.parse(url);
  return uri.pathSegments.last; // Extract '12345' from the URL
}
