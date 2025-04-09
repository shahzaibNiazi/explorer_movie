import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/shared_widgets/appbar_custom.dart';
import 'package:moview_explorer_app/app/shared_widgets/my_text.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:sizer/sizer.dart';
import '../controllers/favorite_movies_controller.dart';

class FavoriteMoviesView extends GetView<FavoriteMoviesController> {
  const FavoriteMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteMoviesController>(
      init: FavoriteMoviesController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarCustom(
            title: '',
            titleSize: 22.sp,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title: "Favorites",size:22.sp,weight: FontWeight.w500).paddingSymmetric(horizontal: 16),

              SizedBox(height: 2.h),
              controller.favoriteMovies.isEmpty
                  ? const Center(child: Text("No favorite movies yet."))
                  : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                    itemCount: controller.favoriteMovies.length,
                    itemBuilder: (context, index) {
                    MovieData movie = controller.favoriteMovies[index];
                    return ListTile(
                      onTap: () {
                        // Navigate to movie details or handle tap
                      },
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: MyText(title: movie.title ?? ''),
                      subtitle: MyText(title: movie.releaseDate.toString()),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.heart_fill, color: Colors.red),
                        onPressed: () {
                          controller.toggleFavorite(movie);
                        },
                      ),
                    );
                                    },
                                  ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
