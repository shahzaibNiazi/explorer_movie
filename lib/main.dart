import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/routes/app_pages.dart';
import 'package:moview_explorer_app/app/shared_widgets/theme_controller.dart';
import 'package:moview_explorer_app/data/provider/network/local_storage/local_db.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency injection
  Get.put(LocalDB());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetBuilder<ThemeController>(
          init: ThemeController(),
          builder: (themeController) {
            return MaterialApp.router(
              title: "Movie Explorer App",
              debugShowCheckedModeBanner: false,
              routerConfig: router, // from AppPages
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                primaryColor: AppColors.primary,
              ),
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: const Color(0xFF020202),
              ),
              themeMode: themeController.themeMode, // dynamic theme support
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(
                    textScaler: const TextScaler.linear(1.1),
                  ),
                  child: child ?? const SizedBox(),
                );
              },
            );
          },
        );
      },
    );
  }
}
