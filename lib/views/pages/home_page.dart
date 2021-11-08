import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/widgets/button.dart';

import '../../services/theme_services.dart';
import 'notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.change_circle),
          onPressed: () {
            ThemeServices().switchThemeMode();
            Get.to(() =>
                const NotificationScreen(payLoad: 'Title|Description|20/10'));
          },
        ),
      ),
      body: Center(
          child: MyButton(
        label: 'Add Task',
        onTap: () {},
      )),
    );
  }
}
