import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mvv_tracker/constants/colors.dart';
import 'package:mvv_tracker/utils/logger.dart';

final ThemeProvider = StateProvider<ThemeMode>((ref) {
  final logger = getLogger("ThemeProvider");
  var themeMode = "dark"; // TODO: Make this configurable

  logger.d("Current themeMode $themeMode");

  if (themeMode == "light") {
    return ThemeMode.light;
  } else if (themeMode == "dark") {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
});

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  primaryColor: darkBackgroundColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  hintColor: Colors.grey[600],
  fontFamily: 'WorkSans',
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(fontFamily: 'WorkSans'),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
      fontFamily: 'WorkSans',
      color: Color.fromARGB(255, 35, 36, 37),
    ),
    backgroundColor: darkBackgroundColor,
    foregroundColor: darkPrimaryColor,
    elevation: 1,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color.fromARGB(255, 35, 36, 37),
    selectedItemColor: darkPrimaryColor,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: darkBackgroundColor,
    scrimColor: Colors.white.withOpacity(0.1),
  ),
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    headline2: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 148, 151, 155),
    ),
    headline3: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: darkPrimaryColor,
    ),
  ),
  cardColor: Colors.grey[900],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor: darkPrimaryColor,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  hintColor: Colors.indigo,
  fontFamily: 'WorkSans',
  scaffoldBackgroundColor: backgroundColor,
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(fontFamily: 'WorkSans'),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
      fontFamily: 'WorkSans',
      color: Colors.indigo,
    ),
    backgroundColor: backgroundColor,
    foregroundColor: Colors.indigo,
    elevation: 1,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: backgroundColor,
    selectedItemColor: Colors.indigo,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: backgroundColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.indigo,
    ),
    headline2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headline3: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.indigo,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
  ),
);
