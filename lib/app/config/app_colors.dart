import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color primaryBlack = Color(0xFF0C1320);
  static const Color trans = Colors.transparent;
  static const Color primary = Colors.blueAccent;
  static const Color secondary = Color(0xFFE75659);
  static const Color redPrimary = Color(0xFFE75659);
  static const Color amber = Color(0xFFF59E0B);
  static const Color yellow = Color(0xFFFCD301);
  static const Color blue = Color(0xFF004BFE);
  static const Color text = Color(0xFFF4F8FB);
  static const Color tertiary = Color(0xFF27C4F4);
  static const Color inputfield = Color(0xFFC4C4C4);
  static const Color lightWhite = Color(0xffDCDCDC);
  static const Color backgroundShadow = Color(0xFFF7F7FB);
  static const Color hint = Color(0xFF6C6C6C);
  static const Color lightGrey = Color(0xFFF7F7F7);
  static const Color grey2 = Color(0xFFAEAEAE);
  static const Color greyBackground = Color(0xFFF8F8F8);
  static const Color primaryBody = Color(0xFF475467);
  static const Color grey85 = Color(0xFF667085);
  static const Color disabledButton =  Color.fromARGB(255, 223, 246, 211);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xffFFED8F), // Start color
      Color(0xff1E61FF), // End color
    ],
    begin: Alignment.centerRight, // Gradient direction
    end: Alignment.centerLeft,
  );
  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [
      Color(0xffFFD880),
      Color(0xffD09203),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      secondary,
      primary,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient dealGradient = LinearGradient(
    colors: [
      Color(0xFF005EBD),
      Color(0xFFFF5252),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
