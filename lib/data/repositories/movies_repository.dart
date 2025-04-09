import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class MoviesRepository{
  late APIProvider apiClient;

  MoviesRepository() {
    apiClient = APIProvider();
  }


  Future getPopularMovies(int page) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      '${ApiEndPoints.popularMovies}?page=$page',
      {},
      true,
      Get.context
    );
    print(data);
    return data;
  }

  Future searchMovies(query) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        '${ApiEndPoints.searchMovies}?query=$query',
        {},
        true,
        Get.context
    );
    print(data);
    return data;
  }


  Future getMovieById(id) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        '${ApiEndPoints.movieById}/$id',
        {},
        true,
        Get.context
    );
    print(data);
    return data;
  }


}