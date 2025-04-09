import 'dart:convert';

import 'package:get/get.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesController extends GetxController {
  //TODO: Implement FavoriteMoviesController

  final count = 0.obs;
  List<MovieData> favoriteMovies = [];

  @override
  void onInit() {
    super.onInit();
    loadFavorites();

  }



  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString('favorites');
    if (saved != null) {
      List list = jsonDecode(saved);
      favoriteMovies = list.map((e) => MovieData.fromJson(e)).toList();
    }

    update();
  }

  void toggleFavorite(MovieData movie) {
    final index = favoriteMovies.indexWhere((m) => m.id == movie.id);
    if (index != -1) {
      favoriteMovies.removeAt(index);
    } else {
      favoriteMovies.add(movie);
    }
    update();
  }




}
