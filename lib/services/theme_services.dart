import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  GetStorage box = GetStorage();
  final key = 'isDarkMode';
  bool loadFromBox() {
    return box.read<bool>(key) ?? false;
  }

  void savetoBox(bool isDarkMode) {
    box.write(key, isDarkMode);
  }

  ThemeMode get theme => loadFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchThemeMode() {
    Get.changeThemeMode(
      loadFromBox() ? ThemeMode.light : ThemeMode.dark,
    );
    savetoBox(!loadFromBox());
  }
}
