import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/routes/app_pages.dart';
import 'package:moview_explorer_app/app/shared_widgets/appbar_custom.dart';
import 'package:moview_explorer_app/app/shared_widgets/my_text.dart';
import 'package:moview_explorer_app/app/shared_widgets/textfield.dart';
import 'package:moview_explorer_app/data/models/movies_model.dart';
import 'package:moview_explorer_app/data/provider/network/api_endpoint.dart';
import 'package:sizer/sizer.dart';

import '../controllers/search_movies_controller.dart';

class SearchMoviesView extends GetView<SearchMoviesController> {
  const SearchMoviesView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchMoviesController>(
        init: SearchMoviesController(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarCustom(),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText(title: "Search",size:22.sp,weight: FontWeight.w500),
                  InputTextField(
                    hint: "Search",
                    onchange: (v) {
                      if (v != null) {
                        controller.onSearchChanged(v.trim());
                      }
                    },
                    focusNode: controller.focusNode,
                  ).paddingOnly(top: 4.h, bottom: 3.h),


                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                            !controller.isMoviesLoading &&
                            controller.hasMoreEvent &&
                            controller.searchMovieList.isEmpty) {
                          controller.getMoviesList(isLoadMore: true);
                          return true;
                        }
                        return false;
                      },
                      child: controller.isMoviesLoading && controller.searchMovieList.isEmpty
                          ? const Center(child: CupertinoActivityIndicator())
                          : controller.searchMovieList.isNotEmpty
                          ? _buildMovieList(controller.searchMovieList, controller)
                          : _buildMovieList(controller.moviesList, controller),
                    ),
                  )

                ],
              ).paddingSymmetric(horizontal: 15),
            ),
          );
        }
    );
  }
  Widget _buildMovieList(List<MovieData> movies, SearchMoviesController controller) {
    if (movies.isEmpty) {
      return const Center(child: Text("No movies found."));
    }

    return ListView.builder(
      itemCount: movies.length + (controller.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == movies.length && controller.isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        MovieData movie = movies[index];
        return ListTile(
          onTap: () => Get.toNamed(Routes.MOVIE_DETAIL, arguments: {"movie": movie}),
          leading: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${ApiEndPoints.movieBaseUrl}${movie.posterPath}',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CupertinoActivityIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
                },
              ),
            ),
          ),
          title: MyText(
            title: movie.title ?? '',
            clr: !Get.isDarkMode ? AppColors.primaryBlack : AppColors.white,
          ),
          subtitle: MyText(title: movie.releaseDate ?? ''),
          trailing: IconButton(
            icon: Icon(
              movie.isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: movie.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              controller.toggleFavorite(movie);
            },
          ),
        );
      },
    );
  }


}
