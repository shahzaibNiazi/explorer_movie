import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../../presentation/favorite_movies/bindings/favorite_movies_binding.dart';
import '../../presentation/favorite_movies/views/favorite_movies_view.dart';
import '../../presentation/home/bindings/home_binding.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/main/bindings/main_binding.dart';
import '../../presentation/main/views/main_view.dart';
import '../../presentation/movie_detail/bindings/movie_detail_binding.dart';
import '../../presentation/movie_detail/views/movie_detail_view.dart';
import '../../presentation/search_movies/bindings/search_movies_binding.dart';
import '../../presentation/search_movies/views/search_movies_view.dart';
import '../../presentation/splash/bindings/splash_binding.dart';
import '../../presentation/splash/views/splash_view.dart';

part 'app_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.MAIN,
  routes: [
    GoRoute(
      path: Routes.SPLASH,
      pageBuilder: (context, state) {
        SplashBinding().dependencies(); // Inject bindings manually
        return const MaterialPage(child: SplashView());
      },
    ),
    GoRoute(
      path: Routes.HOME,
      pageBuilder: (context, state) {
        HomeBinding().dependencies();
        return const MaterialPage(child: HomeView());
      },
    ),
    GoRoute(
      path: Routes.MOVIE_DETAIL,
      pageBuilder: (context, state) {
        MovieDetailBinding().dependencies();
        return const MaterialPage(child: MovieDetailView());
      },
    ),
    GoRoute(
      path: Routes.MAIN,
      pageBuilder: (context, state) {
        MainBinding().dependencies();
        return const MaterialPage(child: MainView());
      },
    ),
    GoRoute(
      path: Routes.SEARCH_MOVIES,
      pageBuilder: (context, state) {
        SearchMoviesBinding().dependencies();
        return const MaterialPage(child: SearchMoviesView());
      },
    ),
    GoRoute(
      path: Routes.FAVORITE_MOVIES,
      pageBuilder: (context, state) {
        FavoriteMoviesBinding().dependencies();
        return const MaterialPage(child: FavoriteMoviesView());
      },
    ),
  ],
);
