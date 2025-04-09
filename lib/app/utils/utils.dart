import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/app_colors.dart';
import 'package:intl/intl.dart';

import '../shared_widgets/custom_confirmation_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;


class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getIconPath(String name, {String format = 'png'}) {
    return 'assets/icons/$name.$format';
  }

  static String formatDate(DateTime date, {String? format}) {
    return DateFormat(format ?? 'd MMM , yyyy').format(date);
  }

  static String getSvgPath(String name, {String format = 'svg'}) {
    return 'assets/svgIcons/$name.$format';
  }

  static String formatDateTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime); // Example: 2025-01-29 11:46 AM
  }
  static String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString); // Parse the input date
    return DateFormat("d MMM yyyy hh:mm a").format(dateTime); // Format the date
  }


  static String formated(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal(); // Convert to local time
    return DateFormat("d MMM yyyy hh:mm a").format(dateTime); // Format the date
  }



  static bool validateEmail(String value) {
    String pattern =
        r'^[a-zA-Z0-9][a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }



 static String  timeAGoMessage(timestamp){
    DateTime messageTime = DateTime.parse(timestamp).toLocal(); // Convert to local time
    String timeAgo = timeago.format(messageTime, locale: 'en');

    return timeAgo;
  }

  static String? getTableByNumber(String tableNumber) {
    switch (tableNumber) {
      case "1":
        return 'assets/svgs/four-capacity.svg';
      case "2":
        return 'assets/svgs/two-capacity.svg';
      case "3":
        return 'assets/svgs/four-capacity.svg';
      case "4":
        return 'assets/svgs/six-capacity-h.svg';
      case "5":
        return 'assets/svgs/four-capacity.svg';
      case "6":
        return 'assets/svgs/four-capacity.svg';
      case "7":
        return 'assets/svgs/six-capacity-v.svg';
      case "8":
        return 'assets/svgs/two-capacity.svg';
      case "9":
        return 'assets/svgs/six-capacity-v.svg';
    }
  }

 static String formatDuration(String? duration) {
   DateTime currentTime = DateTime.now().toUtc();
   DateTime createdTime = DateTime.parse(
       duration ??
           DateTime.now().toUtc().toString());
   Duration difference = currentTime.difference(createdTime);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    // Build the string
    String result = '';
    if (days > 0) result += '$days days, ';
    if (hours > 0) result += '$hours hours, ';
    if (minutes > 0) result += '$minutes minutes, ';
    result += '$seconds seconds';

   String res =  result.trim().replaceAll(RegExp(r',\s*$'), ''); // Remove trailing comma
    return res.split(',')[0];
  }

  static bool isDateBeforeToday(DateTime date) {
    DateTime today = DateTime.now().subtract(const Duration(days: 1));
    return date.isBefore(today);
  }

  static showBottomSheet(Widget sheetWidget,
      {bool isDismissible = true,
      Color? barrierColor,
      BorderRadius? borderRadius}) {
    return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      barrierColor: barrierColor ?? AppColors.black.withOpacity(.4),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(0)),
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
                child: sheetWidget),
          ),
        );
      },
    );
  }

  static void willPopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'We’re sorry to see you leave!'.tr,
          subTitle: 'Are you sure you want to exit app?'.tr,
          yesOnTap: () {
            Get.back();
            SystemNavigator.pop();
          },
        );
      },
    );
  }

  static String getProfilePath(String name, {String format = 'png'}) {
    return 'assets/icons/profile_icons/$name.$format';
  }

  static showToast({required String message, int time = 3}) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: time,
        backgroundColor: AppColors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  static void setStatusBarColorDark() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  static bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }






  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<bool> getPermissionStatus(
      {Permission permission = Permission.photos}) async {
    var status = await permission.status;
    print(status.isDenied);

    if (status.isGranted) {
      return true;

      // onNewCameraSelected(cameras[0]);
      // refreshAlreadyCapturedImages();
    } else if (status.isDenied) {
      await permission.request();
      status = await permission.status;
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      await openAppSettings();
      status = await permission.status;
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static String getDay(DateTime createdAt) {
    //DateTime currentDate = DateTime.now();
    final today = DateTime.now().subtract(const Duration(days: 0));
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final thisWeek7 = DateTime.now().subtract(const Duration(days: 7));
    final thisWeek6 = DateTime.now().subtract(const Duration(days: 6));
    final thisWeek5 = DateTime.now().subtract(const Duration(days: 5));
    final thisWeek4 = DateTime.now().subtract(const Duration(days: 4));
    final thisWeek3 = DateTime.now().subtract(const Duration(days: 3));
    final thisWeek2 = DateTime.now().subtract(const Duration(days: 2));

    if (today.day == createdAt.day) {
      return "Today".tr;
    }

    // else if ((currentDate.day - createdAt.day <= 1) || (currentDate.day - createdAt.day == -29)  || (currentDate.day - createdAt.day == -30) || (currentDate.day - createdAt.day == -27)) {
    //   return "Yesterday";
    // }

    else if (yesterday.day == createdAt.day) {
      return "Yesterday".tr;
    }
    // else if (currentDate.day - createdAt.day == 7 ||
    //     currentDate.day - createdAt.day < 0) {
    //   return "This Week";
    // }
    else if (thisWeek7.day == createdAt.day) {
      return "This Week".tr;
    } else if (thisWeek6.day == createdAt.day) {
      return "This Week".tr;
    } else if (thisWeek5.day == createdAt.day) {
      return "This Week".tr;
    } else if (thisWeek4.day == createdAt.day) {
      return "This Week".tr;
    } else if (thisWeek3.day == createdAt.day) {
      return "This Week".tr;
    } else if (thisWeek2.day == createdAt.day) {
      return "This Week".tr;
    }
    // else if (currentDate.day - createdAt.day > 7 &&
    //     currentDate.month - createdAt.month >= 1) {
    //   return "Earlier";
    // }
    return "Earlier".tr;
  }

  // static Future<String> getFileUrl(String fileName) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return "${directory.path}/$fileName";
  // }



 static int convertToMinutes(String interval) {
    // Split the input into parts (e.g., "2 h 10 min" -> ["2", "h", "10", "min"])
    final parts = interval.split(' ');

    int hours = 0;
    int minutes = 0;
    // Parse the parts
    for (int i = 0; i < parts.length; i += 2) {
      final value = int.tryParse(parts[i]) ?? 0;
      if (parts[i + 1] == 'h') {
        hours = value;
      } else if (parts[i + 1] == 'min') {
        minutes = value;
      }
    }
    // Convert hours and minutes to total minutes
    return (hours * 60) + minutes;
  }


  static String convertToFormattedInterval(int totalMinutes) {
    // Calculate hours and remaining minutes
    int hours = totalMinutes ~/ 60; // Integer division to get hours
    int minutes = totalMinutes % 60; // Modulus to get remaining minutes

    // Build the formatted string
    String formattedInterval = '';
    if (hours > 0) {
      formattedInterval += '$hours h';
    }
    if (minutes > 0) {
      if (formattedInterval.isNotEmpty) {
        formattedInterval += ' ';
      }
      formattedInterval += '$minutes min';
    }

    return formattedInterval;
  }






}
