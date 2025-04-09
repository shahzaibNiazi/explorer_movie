import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:moview_explorer_app/data/repositories/movies_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  RxBool isLoadingMore = false.obs;

  MoviesRepository moviesRepository=MoviesRepository();
  FocusNode focusNode=FocusNode();
  RxBool isMoviesLoading=false.obs;

  List<MovieData> moviesList=[];

  bool isMoreMoviesAvailable=false;
   RxBool hasMoreEvent = true.obs;
  int currentPageEvent = 1;
  List<MovieData> favoritesList = [];
  List<MovieData> searchMovieList = [];
  Timer? _debounce;
  late SharedPreferences prefs;


  @override
  void onInit() {
    super.onInit();
    _initPrefs();
    getMoviesList();
    loadFavorites();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _loadCachedData(); // Load cached data on initialization
  }


  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMovies(query);
    });
  }



  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> getMoviesList({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isMoviesLoading.value = true;
    }
    update();

    bool isConnected = await _checkInternetConnection();

    if (isConnected) {
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
            moviesList.assignAll(fetchedMoviesList);
          }

          // Save to SharedPreferences
          await _saveToPrefs(moviesList);

          if (fetchedMoviesList.isEmpty) {
            hasMoreEvent.value = false;
          }

          if (moviesList.length % 10 == 0) {
            currentPageEvent++;
          } else {
            hasMoreEvent.value = false;
          }
        } else {
          hasMoreEvent.value = false;
        }
      } catch (e) {
        Get.log('Error: $e');
        _loadCachedData();
      }
    } else {
      _loadCachedData();
      Get.snackbar('No Internet', 'Showing cached data');
    }

    isMoviesLoading.value = false;
    isLoadingMore.value = false;
    update();
  }



  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchMovieList.clear();
      update();
      return;
    }

    isMoviesLoading.value = true;
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
      isMoviesLoading.value = false;
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

  Future<void> _saveToPrefs(List<MovieData> movies) async {
    String jsonString = jsonEncode(movies.map((movie) => movie.toJson()).toList());
    await prefs.setString('cached_movies', jsonString);
  }

  void _loadCachedData() {
    String? jsonString = prefs.getString('cached_movies');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      moviesList.assignAll(
        jsonList.map((json) => MovieData.fromJson(json)).toList(),
      );
      for (var movie in moviesList) {
        movie.isFavorite = favoritesList.any((fav) => fav.id == movie.id);
      }
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }


}
