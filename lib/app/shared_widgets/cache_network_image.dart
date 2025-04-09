import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';

class CacheNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String url;
  final double? borderWidth;
  const CacheNetworkImage({
    super.key, this.height, this.width, required this.url, this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height??45,
      width: width??45,
      imageUrl: url,
      imageBuilder: (context, imageProvider) =>
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: borderWidth!=null? Border.all(
                color: AppColors.grey2,
                width: borderWidth!,
              ):null,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
      placeholder: (context, url) =>
          CupertinoActivityIndicator(),
      errorWidget: (context, url, error) =>
          Icon(Icons.error),
    );
  }
}
