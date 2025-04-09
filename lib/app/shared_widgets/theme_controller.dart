
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/app/config/global_var.dart';
import 'package:moview_explorer_app/app/config/local_keys.dart';
import 'package:moview_explorer_app/data/provider/network/local_storage/local_db.dart';




class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getSavedThemeMode();
  }

  // GetStorage box = GetStorage();

  ThemeMode themeMode = ThemeMode.dark;

  Future<void> setThemeMode(ThemeMode theme) async {
    Get.changeThemeMode(theme);
    themeMode = theme;
    LocalDB.setData("theme", themeMode.toString().split('.')[1]);
    update();
  }

  getSavedThemeMode() async {
    var savedTheme = LocalDB.getData("theme") ?? "dark";
    // import 'package:flutter/foundation.dart';for this
    themeMode = ThemeMode.values.firstWhereOrNull((e) => e.name == savedTheme) ?? ThemeMode.system;
    Get.changeThemeMode(themeMode);
    update();
  }
}