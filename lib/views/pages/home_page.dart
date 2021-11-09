import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../size_config.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

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
    SizeConfig().init(context);
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
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              label: 'Add Task',
              onTap: () {},
            ),
            const InputField(
              title: 'Title',
              hint: 'hint',
              widget: Icon(Icons.save),
            )
          ],
        ),
      )),
    );
  }
}
