import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/pages/notification_screen.dart';

import 'views/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        backgroundColor: Colors.teal,
      ),
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      home: const NotificationScreen(
        payLoad: 'sss|dsdsd',
      ),
    );
  }
}
