import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/shared_widgets/constant.dart';

class MyText extends StatelessWidget {
  final String? title, family;
  final FontWeight? weight;
  final double? size;
  final Color? clr;
  final Color? decorationColor;
  final bool? lineThrough;
  final int? line;
  final double? lineThikness;
  final bool isInter;
  final TextAlign? textAlign;
  final Paint? bgColor;
  final double? letterSpacing;
  final double? wordsSpacing;
  final TextOverflow? overFLow;
  final TextDirection? textDirection;

  const MyText(
      {super.key,
      this.title,
      this.size,
      this.isInter = true,
      this.clr,
      this.textDirection,
      this.overFLow,
      this.weight,
      this.family,
      this.bgColor,
      this.lineThrough = false,
      this.line,
      this.letterSpacing,
      this.wordsSpacing,
      this.textAlign,
      this.decorationColor, this.lineThikness});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = isInter
        ? GoogleFonts.inter(
            fontWeight: weight,
            fontSize: size,
            wordSpacing: wordsSpacing,
            letterSpacing: letterSpacing,
            color: clr?? (!isDarkMode(context) ? AppColors.primaryBlack :AppColors.white),
            decorationColor: decorationColor,
            decoration: lineThrough == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      decorationThickness: lineThrough == true ? lineThikness : null)
        : GoogleFonts.inter(
            fontWeight: weight,
            fontSize: size,
            wordSpacing: wordsSpacing,
            letterSpacing: letterSpacing,
            color: clr?? (!isDarkMode(context) ? AppColors.primaryBlack :AppColors.white),
            decoration: TextDecoration.none,
          );

    return Text(title!,
        textDirection: textDirection ?? TextDirection.ltr,
        maxLines: line,
        softWrap: true,
        overflow: overFLow,
        style: textStyle,
        textAlign: textAlign);
  }
}
