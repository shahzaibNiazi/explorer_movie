import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/shared_widgets/constant.dart';
import 'package:moview_explorer_app/app/utils/utils.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
            bottomNavigationBar: Container(
              decoration:  BoxDecoration(
                color: isDarkMode(context) ? AppColors.primaryBlack :AppColors.white,
              ),
              child: BottomNavigationBar(
                unselectedFontSize: 12,
                selectedFontSize: 12,
                elevation: 10,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: '',
                  ),
                ],
                currentIndex: controller.currentIndex,
                selectedItemColor: AppColors.primary,
                unselectedItemColor:!isDarkMode(context) ? AppColors.black :AppColors.white,
                type: BottomNavigationBarType.fixed,
                backgroundColor: isDarkMode(context)  ? AppColors.primaryBlack :AppColors.white,
                showUnselectedLabels: true,
                onTap: (index) {
                  controller.setPageIndex(index);
                },
              ),
            ),
             body:  controller.pages[controller.currentIndex],


          );
        }
    );
  }
}
