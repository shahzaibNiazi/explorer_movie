
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/app/shared_widgets/my_text.dart';
import 'package:moview_explorer_app/app/utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../config/app_colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  // final bool? trailing;
  final double? leadingWidth;
  final double? titleSize;
  final bool centerTitle;
  final bool bar;
  final Color? color;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;

  const AppBarCustom({
    super.key,
    this.title,
    this.titleSize,
    this.color,
    this.actions,
    this.onLeadingPressed,
    this.leadingWidth,
    this.centerTitle = false,
    this.bar = false,
    //  this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trans,
      surfaceTintColor: AppColors.trans,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: title == null
          ? null
          : MyText(
              title: title ?? '',
              weight: FontWeight.w400,
              size:titleSize?? 14.sp,
              clr:color ?? AppColors.black,
            ),
      // Text(
      //     title!,
      //     style: AppTextStyles.heading,
      //   ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false, leadingWidth: leadingWidth ?? 60,
      leading: onLeadingPressed == null
          ? null
          : IconButton(
              color: AppColors.trans,
              onPressed: onLeadingPressed, // Call the callback function here
              icon: Image.asset(Utils.getIconPath('arrow_left'),scale: 4.0,),
            ).paddingOnly(left: 6),
         actions: actions,
      bottom: bar? PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.hint.withOpacity(0.30), 
          height: 1.5, // Thickness of the border
        ),
      ): null,
      // actions:trailing==null?null: [
      //   IconButton(
      //     color: AppColors.white,
      //     onPressed: () {
      //       Get.toNamed(Routes.NOTIFICATIONS);
      //     },
      //     icon: Container(
      //         padding: EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //             color: AppColors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: AppColors.black
      //                       .withOpacity(0.15),
      //                   blurRadius: 32,
      //                   spreadRadius: 0,
      //                   offset: const Offset(6, 5))
      //             ]),
      //         child: Image.asset(Utils.getIconPath('Bell'),scale: 4.0,)),
      //   )
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
