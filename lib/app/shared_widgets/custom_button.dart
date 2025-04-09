
import 'package:dio_log/http_log_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moview_explorer_app/app/config/app_colors.dart';
import 'package:moview_explorer_app/app/extensions/extensions.dart';
import 'package:moview_explorer_app/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onPress;
  final double? height;
  final double? width;
  final Color textColor;
  final Color? borderColor;
  final Color boxColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final FontWeight? weight;
  // final Duration duration;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.fontWeight,
      required this.text,
      required this.onPress,
      required this.textColor,
      required this.boxColor,
      // required this.duration,
      this.fontSize,
      this.radius,
      this.weight, this.borderColor});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HttpLogListWidget(),
          ),
        );
      },
      child: Container(
        width: (widget.width ?? double.infinity) , // Animation logic
        height: (widget.height ?? 50),
        decoration: BoxDecoration(
          color: widget.boxColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
          border: Border.all(color:widget.borderColor?? AppColors.trans)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.lightbulb,size: 16),
            Center(
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontWeight: widget.weight ?? FontWeight.w400,
                  fontSize: widget.fontSize ?? 16,
                  color: widget.textColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatefulWidget {
  final String text;
  final Widget? icon;
  final Function()? onPress;
  final double? height;
  final double? width;
  final Color textColor;
  final Color boxColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final bool isIcon;
  final FontWeight? weight;
  const CustomButtonWithIcon(
      {super.key,
      this.width,
      this.height,
      this.fontWeight,
      required this.text,
      required this.onPress,
      required this.textColor,
      required this.boxColor,
      this.fontSize,
      this.radius,
      this.weight, this.icon, this.isIcon=true});

  @override
  State<CustomButtonWithIcon> createState() => _CustomButtonWithIconState();
}

class _CustomButtonWithIconState extends State<CustomButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      onLongPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HttpLogListWidget(),
          ),
        );
      },
      child: Container(
        width: (widget.width ?? double.infinity) , // Animation logic
        height: (widget.height ?? 50),
        decoration: BoxDecoration(
          color: widget.boxColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 12),
        ),
        // duration: widget.duration,
        // curve: Curves.easeInOut, // Animation curve
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontWeight: widget.weight ?? FontWeight.w400,
                  fontSize: widget.fontSize ?? 18.sp,
                  color: widget.textColor,
                  decoration: TextDecoration.none,
                ),
              ),
              2.w.width,
              widget.icon??Image.asset(Utils.getIconPath('arrow_right'),scale: 4.0,)
            ],
          ),
        ),
      ),
    );
  }
}
