import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/constant.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.white,
  // ignore: deprecated_member_use
  // backgroundColor: AppColor.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColor.white,
    unselectedItemColor: AppColor.black,
    selectedItemColor: AppColor.black,
    elevation: 0,
  ),
  fontFamily: Constant.fontFamilySFProDisplay,
  highlightColor: AppColor.transparent,
  splashColor: AppColor.transparent,
);
