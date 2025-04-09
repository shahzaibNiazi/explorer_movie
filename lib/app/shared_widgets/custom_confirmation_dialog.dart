
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moview_explorer_app/app/extensions/extensions.dart';
import 'package:moview_explorer_app/app/shared_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../app/config/app_colors.dart';
import 'my_text.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final Widget? titleFull;
  final String subTitle;
  final VoidCallback yesOnTap;
  const ConfirmationDialog(
      {super.key,
       this.title,
      required this.subTitle,
      required this.yesOnTap, this.titleFull});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // // Close Button
            // Align(
            //   alignment: Alignment.topRight,
            //   child: IconButton(
            //     icon: const Icon(
            //       Icons.close,
            //       color: AppColors.black,
            //       size: 18,
            //     ),
            //     onPressed: () {
            //       Get.back(); // Closes the dialog
            //     },
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               titleFull?? MyText(
                  title: title,
                  weight: FontWeight.w600,
                  size: 19.sp,
                  clr: AppColors.secondary,
                ),
                .5.h.height,
                MyText(
                  title: subTitle,
                  weight: FontWeight.w400,
                  size: 16.sp,
                  clr: AppColors.primaryBlack,
                  textAlign: TextAlign.center,
                ),
                4.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(text: 'No', onPress: () {
                              Get.back();
                      }, textColor: AppColors.text, boxColor: AppColors.secondary),
                    ),
                    3.w.width,
                    Expanded(
                      child: CustomButton(text: 'Yes', onPress: yesOnTap, textColor: AppColors.text, boxColor: AppColors.primary),
                    ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: yesOnTap,
                    //     child: Container(
                    //       height: 50,
                    //       alignment: Alignment.center,
                    //       padding: const EdgeInsets.symmetric(vertical: 5),
                    //       decoration: BoxDecoration(
                    //           color: AppColors.primary,
                    //           borderRadius: BorderRadius.circular(4)),
                    //       child: MyText(
                    //         title: 'Yes'.tr,
                    //         weight: FontWeight.w500,
                    //         size: 12.sp,
                    //         clr: AppColors.inputfield,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ).paddingAll(20),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
