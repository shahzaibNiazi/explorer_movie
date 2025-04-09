import 'dart:convert';

import 'package:get/get.dart';
import 'package:moview_explorer_app/data/models/movie_detail_model.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:moview_explorer_app/data/repositories/movies_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailController extends GetxController {
  //TODO: Implement MovieDetailController

  final count = 0.obs;
  MoviesRepository moviesRepository=MoviesRepository();

  MovieData movies=MovieData();
  MovieDetailData movieData=MovieDetailData();
  List<MovieData> favoritesList = [];
  bool isFavorite=false;

  bool isMoviesLoading=false;

  @override
  void onInit() {
    super.onInit();
    movies = Get.arguments['movie'];
    getMovieById(movies.id);
    loadFavorites();
  }



  Future<void> getMovieById(id) async {
    isMoviesLoading = true;
    update();
    try {
      var response = await moviesRepository.getMovieById(id);
      if (response != null) {
        movieData = MovieDetailData.fromJson(response);
       update();
      }
    } catch (e) {
      Get.log('Error: $e');
    } finally {
      isMoviesLoading = false;
      update();
    }
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString('favorites');
    if (saved != null) {
      List list = jsonDecode(saved);
      favoritesList = list.map((e) => MovieData.fromJson(e)).toList();
      isFavorite = favoritesList.any((fav) => fav.id == movies.id);
      update();
    }
  }

  Future<void> toggleFavorite(MovieData movie) async {
    final isExist = favoritesList.any((item) => item.id == movie.id);
    if (isExist) {
      favoritesList.removeWhere((item) => item.id == movie.id);

      movie.isFavorite = false;
    } else {
      favoritesList.add(movie);
      movie.isFavorite = true;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> mapped = favoritesList.map((e) => e.toJson()).toList();
    prefs.setString('favorites', jsonEncode(mapped));
    update();
  }


}
