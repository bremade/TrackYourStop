import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/constants/colors.dart';
import 'package:mvv_tracker/utils/logger.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  final logger = getLogger("ThemeProvider");
  var configuredMode = "dark"; // TODO: Make this configurable
  var themeMode = ThemeMode.system;

  if (configuredMode == "light") {
    themeMode = ThemeMode.light;
  } else if (configuredMode == "dark") {
    themeMode = ThemeMode.dark;
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: themeMode == ThemeMode.dark ? darkStatusBar : statusBar,
      systemNavigationBarColor:
          themeMode == ThemeMode.dark ? darkStatusBar : statusBar));

  logger.d("Current themeMode $themeMode");
  return themeMode;
});

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    hintColor: Colors.grey[600],
    fontFamily: 'WorkSans',
    appBarTheme: const AppBarTheme(
        //elevation: 2.0,
        color: Color(0xff616d8f)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkBackgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: darkLightPrimaryColor),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: darkSecondaryColor),
    chipTheme: ChipThemeData(
      backgroundColor: darkLightPrimaryColor,
      deleteIconColor: Colors.white,
      elevation: 6.0,
      labelPadding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0
      ),
      side: const BorderSide(style: BorderStyle.none),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    hintColor: Colors.grey[600],
    fontFamily: 'WorkSans',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkBackgroundColor,
      selectedItemColor: Colors.white,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: darkSecondaryColor));
