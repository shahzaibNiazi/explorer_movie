import 'package:flutter/material.dart';

bool isDarkMode(ctx){
  return Theme.of(ctx).brightness == Brightness.dark;
}