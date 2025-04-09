import 'package:get/get.dart';

import '../controllers/favorite_movies_controller.dart';

class FavoriteMoviesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteMoviesController>(
      () => FavoriteMoviesController(),
    );
  }
}
