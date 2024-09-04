import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notify/feature/notification/data/repo/data_source.dart';
import 'package:firebase_notify/service/background_notification.dart';
import 'package:firebase_notify/service/foreground_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}

Future<String?> getDeviceToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for iOS devices
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // User granted permission
    String? token = await messaging.getToken();
    print('FCM Token: $token');
    return token;
  } else {
    // User declined or has not accepted permission
    print('User declined or has not accepted permission');
    return null;
  }
}

void configureFirebaseMessaging(String userId) {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for iOS (if applicable)
  messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Handle the token refresh
  messaging.onTokenRefresh.listen((newToken) {
    // Update the token on your server
    saveTokenToServer(newToken, userId);
  });

  // Optionally, handle foreground messages (when the app is running)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a foreground message: ${message.notification?.title}');
    handleForegroundMessage(message);
  });

  // Optionally, handle background messages (when the app is in the background or terminated)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Get the initial token and save it on the server
  messaging.getToken().then((token) {
    saveTokenToServer(token, userId);
  });

  print('Firebase Messaging configured');
}

// Background message handler (this function must be a top-level function)

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showBigPictureNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Channel ID
    'your_channel_name', // Channel name
    channelDescription: 'your_channel_description', // Channel description
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: BigPictureStyleInformation(
      DrawableResourceAndroidBitmap(
          'your_image'), // Replace with your image name in assets
      largeIcon: DrawableResourceAndroidBitmap(
          'your_large_icon'), // Optional: Replace with your large icon in assets
      contentTitle: 'Content Title',
      htmlFormatContentTitle: true,
      summaryText: 'Summary Text',
      htmlFormatSummaryText: true,
    ),
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Title', // Notification title
    'Body', // Notification body
    platformChannelSpecifics,
    payload: 'item x', // Optional: data to pass with the notification
  );
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    largeIcon:
        DrawableResourceAndroidBitmap(''), // Reference the drawable resource
    // Other configuration
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: null,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Notification For School attendance app',
    'Hey its me santosh',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
