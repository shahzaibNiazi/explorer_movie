import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moview_explorer_app/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';

class InputTextField extends StatefulWidget {
  final String? initial;
  final String? hint;
  final String? label;
  final FocusNode? focusNode;
  final String? prefixIcon;
  final String? suffixIcon;
  final Widget? suffix;
  final Color? suffixColor;
  final Color? backgroundColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? prefixColor;
  final VoidCallback? suffixOntap;
  final bool? isSuffix;
  final bool? isPrefixIcon;
  final bool? fromLogin;
  final bool? outLineBorder;
  final bool? isObscure;
  final bool? readOnly;
  final int? maxLines;
  final double? height;
  final double? horizontalPrefixPadding;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onSubmit;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatter;
  const InputTextField(
      {super.key,
      this.maxLines,
      this.height,
      this.focusNode,
      this.isSuffix = false,
      this.isPrefixIcon = false,
      this.fromLogin = false,
      this.isObscure = false,
      this.outLineBorder = false,
      this.hint,
      this.textInputType,
      this.onSaved,
      this.controller,
      this.label,
      this.validation,
      this.onchange,
      this.prefixIcon,
      this.initial,
      this.readOnly,
      this.suffixIcon,
      this.suffixOntap,
      this.suffixColor,
      this.onTap,
      this.inputFormatter,
      this.backgroundColor, this.hintColor, this.fillColor, this.horizontalPrefixPadding, this.prefixColor, this.suffix, this.onSubmit});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatter,
      onTap: widget.onTap,
      initialValue: widget.initial,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (val) {
        if( widget.focusNode!=null) {
          widget.focusNode!.unfocus();
        }
      },
      readOnly: widget.readOnly ?? false,
      keyboardType: widget.textInputType ?? TextInputType.text,
      validator: widget.validation,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      onChanged: widget.onchange,
      obscureText: widget.isObscure ?? false,
      controller: widget.controller,
      cursorColor: AppColors.hint,
      maxLines: widget.maxLines ?? 1,
      style: GoogleFonts.inter(
          color: AppColors.hint, fontSize: 14.sp, fontWeight: FontWeight.w400),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
          labelText: widget.label,
          errorMaxLines: 2,
          prefixIcon:  Icon(CupertinoIcons.search,color: AppColors.black.withOpacity(0.7)),
          hintText: widget.hint,
          filled: true,
          fillColor: widget.fillColor?? AppColors.inputfield.withOpacity(0.2),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          errorBorder: UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.inputfield)),
          focusedBorder: 
          OutlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              borderSide:
                   BorderSide(width: 1, color:widget.backgroundColor ?? AppColors.inputfield.withOpacity(0.20))),
          hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color:  AppColors.black),
          focusedErrorBorder:widget.outLineBorder==true ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: widget.backgroundColor ?? AppColors.inputfield.withOpacity(0.20)))
          :UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              borderSide:
                   BorderSide(width: 1, color:widget.backgroundColor ?? AppColors.inputfield.withOpacity(0.20))),
          enabledBorder: widget.outLineBorder==true ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: widget.backgroundColor ?? AppColors.inputfield.withOpacity(0.20)))
              : UnderlineInputBorder(
              borderRadius: widget.fromLogin == true
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.backgroundColor ?? AppColors.inputfield.withOpacity(0.20)))),
    );
  }
}

