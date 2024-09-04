import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void handleForegroundMessage(RemoteMessage message) {
  // Extract message details
  final notification = message.notification;
  final data = message.data;

  // Print message details (for debugging)
  print('Notification Title: ${notification?.title}');
  print('Notification Body: ${notification?.body}');
  print('Data: $data');

  // Show an in-app dialog
  if (notification != null) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(notification.title ?? 'No Title'),
        content: Text(notification.body ?? 'No Content'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Optionally, navigate to a different screen based on the message
              Navigator.of(context).pushNamed('/details', arguments: data);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Optionally, update the app's UI based on the data
  // For example, you might want to update a widget or state in your app
}
