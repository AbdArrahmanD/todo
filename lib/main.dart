import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/pages/notification_screen.dart';

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
        payLoad:
            'sss|Velit et magna dolor Lorem consectetur pariatur elit sit nostrud commodo aliquip tempor aliqua voluptate. Ad do enim enim elit incididunt commodo officia. Esse voluptate do commodo eu. Exercitation mollit qui deserunt aliqua amet proident et consequat veniam eu. Est qui excepteur ut fugiat ea id pariatur nisi minim reprehenderit quis et eu. Minim anim reprehenderit quis enim sint consequat ullamco velit amet et.|20 / 10/ 2021',
      ),
    );
  }
}
