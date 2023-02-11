import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/constants/colors.dart';
import 'package:settings_ui/settings_ui.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  final ThemeMode themeMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
  setUiStyle(themeMode);
  return themeMode;
});

void setUiStyle(final ThemeMode configuredMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          configuredMode == ThemeMode.dark ? darkStatusBar : statusBar,
      systemNavigationBarColor:
          configuredMode == ThemeMode.dark ? darkStatusBar : statusBar));
}

/////////////////////////////////////
///           Dark Theme          ///
/////////////////////////////////////

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
      padding: const EdgeInsets.only(left: 6.0),
      labelPadding: const EdgeInsets.only(left: 0, right: 0),
      side: const BorderSide(style: BorderStyle.none),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(darkLightPrimaryColor)));

SettingsThemeData darkSettings = SettingsThemeData(
  settingsListBackground: darkBackgroundColor,
  trailingTextColor: Colors.white,
  dividerColor: Colors.white,
  tileHighlightColor: Colors.white,
  titleTextColor: Colors.white,
  leadingIconsColor: Colors.white,
  tileDescriptionTextColor: Colors.white,
  settingsTileTextColor: Colors.white,
  inactiveTitleColor: darkLightPrimaryColor,
  inactiveSubtitleColor: darkLightPrimaryColor,
);

/////////////////////////////////////
///          Light Theme          ///
/////////////////////////////////////

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    hintColor: Colors.grey[600],
    fontFamily: 'WorkSans',
    appBarTheme: const AppBarTheme(
        //elevation: 2.0,
        color: Color(0xffbcaaa4)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: darkBackgroundColor,
        unselectedItemColor: secondaryColor),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: secondaryColor),
    chipTheme: ChipThemeData(
      backgroundColor: statusBar,
      deleteIconColor: secondaryColor,
      elevation: 6.0,
      padding: const EdgeInsets.only(left: 6.0),
      labelPadding: const EdgeInsets.only(left: 0, right: 0),
      side: const BorderSide(style: BorderStyle.none),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(secondaryColor)));

SettingsThemeData lightSettings = SettingsThemeData(
  settingsListBackground: backgroundColor,
  trailingTextColor: primaryTextColor,
  dividerColor: primaryTextColor,
  tileHighlightColor: primaryTextColor,
  titleTextColor: primaryTextColor,
  leadingIconsColor: primaryTextColor,
  tileDescriptionTextColor: primaryTextColor,
  settingsTileTextColor: primaryTextColor,
  inactiveTitleColor: secondaryColor,
  inactiveSubtitleColor: secondaryColor,
);
