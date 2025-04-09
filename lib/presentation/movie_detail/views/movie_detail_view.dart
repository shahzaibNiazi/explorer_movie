import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/shared_widgets/appbar_custom.dart';
import 'package:moview_explorer_app/app/shared_widgets/custom_button.dart';
import 'package:moview_explorer_app/app/shared_widgets/my_text.dart';
import 'package:moview_explorer_app/data/provider/network/api_endpoint.dart';
import 'package:sizer/sizer.dart';

import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  const MovieDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailController>(
      init: MovieDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarCustom(
            titleSize: 16.sp,
            title:controller.movieData.title??'',
            onLeadingPressed: (){
              Get.back();
            },
            centerTitle: true,
          ),
          bottomNavigationBar: SafeArea(child: CustomButton(
              text:  controller.movies.isFavorite? 'Remove from Favorite' :'Add to Favorites', onPress: (){
                controller.toggleFavorite(controller.movies);
          }, textColor: AppColors.black, boxColor: AppColors.white,borderColor: AppColors.primary,weight: FontWeight.w600).paddingAll(12)),
          body:
          controller.isMoviesLoading ?
          const Center(child: CupertinoActivityIndicator()):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '${ApiEndPoints.movieBaseUrl}${controller.movieData.posterPath}',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CupertinoActivityIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),

              MyText(title: controller.movieData.title??'',size: 14.sp,weight: FontWeight.w600).paddingOnly(top: 2.h,bottom: 1.h),
              MyText(title: 'Release ${controller.movieData.releaseDate}',size: 14.sp,weight: FontWeight.w500),
              Row(
                children: [
                  const Icon(Icons.star,size: 15),
                  MyText(title: controller.movieData.voteAverage.toString(),size: 14.sp,weight: FontWeight.w500).paddingOnly(top: 1.h,bottom: 1.h),
                ],
              ),
              MyText(title: controller.movieData.overview??'',size: 14.sp,weight: FontWeight.w500),
            ],
          ).paddingSymmetric(horizontal: 16),
        );
      }
    );
  }
}
