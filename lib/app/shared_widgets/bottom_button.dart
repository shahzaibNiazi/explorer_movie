
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../config/app_colors.dart';
import 'custom_button.dart';

class BottomButton extends StatelessWidget {
  final double? height;
  final Function()? onPress;
  final String title;
  final double? buttonHeight;
  final List<Widget>? children;
  const BottomButton(
      {super.key,
      this.height,
      this.onPress,
        this.buttonHeight,
      required this.title,
      this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height ?? 13.h,
        decoration: BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
              color: AppColors.hint.withOpacity(0.25),
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 0)
        ]),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children ??
              [
                // Center(
                //   child: Container(
                //     height: 0.5.h,
                //     width: 30.w,
                //     decoration: BoxDecoration(
                //         color: AppColors.bottomLineColor,
                //         borderRadius: BorderRadius.circular(4)),
                //   ).paddingOnly(bottom: 3.h),
                // ),
                CustomButton(
                  height:buttonHeight ?? 6.h,
                  text: title,
                  onPress: onPress,
                  textColor: AppColors.white,
                  boxColor: AppColors.primary,
                  // duration: Duration(milliseconds: 600),
                ),
              ],
        ),
      ),
    );
  }
}
