import 'package:firebase_notify/service/firebase_service.dart';
import 'package:flutter/material.dart';

class HandleNotification extends StatefulWidget {
  const HandleNotification({super.key});

  @override
  _HandleNotificationState createState() => _HandleNotificationState();
}

class _HandleNotificationState extends State<HandleNotification> {
  @override
  void initState() {
    showNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTIFICATION"),
      ),
      body: const Column(
        children: <Widget>[
          Center(
            child: Text(
              "HEY",
              style: TextStyle(color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}
