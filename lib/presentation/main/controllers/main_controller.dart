import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/presentation/favorite_movies/views/favorite_movies_view.dart';
import 'package:moview_explorer_app/presentation/home/views/home_view.dart';
import 'package:moview_explorer_app/presentation/search_movies/views/search_movies_view.dart';

class MainController extends GetxController {
  //TODO: Implement MainController

  final count = 0.obs;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }


  final List<Widget> pages = [
    const HomeView(),
    const SearchMoviesView(),
    const FavoriteMoviesView(),
  ];

  setPageIndex(int index) {
    currentIndex = index;
    update();
  }
}
