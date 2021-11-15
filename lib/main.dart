import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/pages/home_page.dart';

import 'services/theme_services.dart';
import 'views/theme.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // NotifyHelper().initializationNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        title: 'ToDo',
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
