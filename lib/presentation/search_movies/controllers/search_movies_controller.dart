import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:moview_explorer_app/data/repositories/movies_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchMoviesController extends GetxController {
  //TODO: Implement SearchMoviesController

  //TODO: Implement HomeController

  final count = 0.obs;
  bool isLoadingMore = false;


  MoviesRepository moviesRepository=MoviesRepository();
  FocusNode focusNode=FocusNode();
  bool isMoviesLoading=false;

  List<MovieData> moviesList=[];

  bool isMoreMoviesAvailable=false;
  bool hasMoreEvent = true;
  int currentPageEvent = 1;
  List<MovieData> favoritesList = [];
  List<MovieData> searchMovieList = [];
  Timer? _debounce;



  @override
  void onInit() {
    super.onInit();

    getMoviesList();
    loadFavorites();
  }


  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMovies(query);
    });
  }



  Future<void> getMoviesList({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isMoviesLoading = true;
    }
    update();

    try {
      var response = await moviesRepository.getPopularMovies(currentPageEvent);
      if (response != null && response['results'] != null) {
        List<MovieData> fetchedMoviesList = (response['results'] as List)
            .map((item) => MovieData.fromJson(item))
            .toList();

        for (var movie in fetchedMoviesList) {
          movie.isFavorite = favoritesList.any((fav) => fav.id == movie.id);
        }

        if (isLoadMore) {
          moviesList.addAll(fetchedMoviesList);
        } else {
          moviesList = fetchedMoviesList;
        }

        if (fetchedMoviesList.isEmpty) {
          hasMoreEvent = false;
        }

        if (moviesList.length % 10 == 0) {
          currentPageEvent++;
        } else {
          hasMoreEvent = false;
        }
      } else {
        hasMoreEvent = false;
      }
    } catch (e) {
      Get.log('Error: $e');
    } finally {
      isMoviesLoading = false;
      isLoadingMore = false;
      update();
    }
  }




  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchMovieList.clear();
      update();
      return;
    }

    isMoviesLoading = true;
    update();
    try {
      var response = await moviesRepository.searchMovies(query);
      if (response != null && response['results'] != null) {
        searchMovieList = (response['results'] as List)
            .map((item) => MovieData.fromJson(item))
            .toList();

        // Mark items as favorite
        for (var movie in searchMovieList) {
          movie.isFavorite = favoritesList.any((fav) => fav.id == movie.id);
        }
      }
    } catch (e) {
      Get.log('Error: $e');
    } finally {
      isMoviesLoading = false;
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

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString('favorites');
    if (saved != null) {
      List list = jsonDecode(saved);
      favoritesList = list.map((e) => MovieData.fromJson(e)).toList();
    }
  }

}
