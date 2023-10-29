import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/constants/colors.dart';
import 'package:settings_ui/settings_ui.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  final ThemeMode themeMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
  setUiStyle(themeMode);
  return themeMode;
});

void setUiStyle(final ThemeMode configuredMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: configuredMode == ThemeMode.dark
          ? secondaryContainerColorDark
          : secondaryContainerColor,
      systemNavigationBarColor: configuredMode == ThemeMode.dark
          ? secondaryContainerColorDark
          : secondaryContainerColor));
}

/////////////////////////////////////
///           Dark Theme          ///
/////////////////////////////////////
ThemeData darkThemeCustom = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, seedColor: const Color(0xFF2196F3)),
    fontFamily: 'WorkSans',
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: onSecondaryContainerColorDark),
        color: secondaryContainerColorDark),
    chipTheme: ChipThemeData(
      backgroundColor: secondaryContainerColorDark,
      deleteIconColor: onSecondaryContainerColorDark,
      elevation: 6.0,
      padding: const EdgeInsets.only(left: 6.0),
      labelPadding: const EdgeInsets.only(left: 0, right: 0),
      side: const BorderSide(style: BorderStyle.none),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ),
    toggleButtonsTheme:
        ToggleButtonsThemeData(selectedColor: primaryColorDark));

SettingsThemeData darkSettings = SettingsThemeData(
    settingsListBackground: backgroundColorDark,
    settingsSectionBackground: secondaryContainerColorDark,
    trailingTextColor: onSecondaryContainerColorDark,
    dividerColor: onSecondaryContainerColorDark,
    tileHighlightColor: onSecondaryContainerColorDark,
    titleTextColor: onSecondaryContainerColorDark,
    leadingIconsColor: onSecondaryContainerColorDark,
    tileDescriptionTextColor: onSecondaryContainerColorDark,
    settingsTileTextColor: onSecondaryContainerColorDark);

/////////////////////////////////////
///          Light Theme          ///
/////////////////////////////////////
ThemeData lightThemeCustom = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)),
    fontFamily: 'WorkSans',
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: onSecondaryContainerColor),
        color: secondaryContainerColor),
    chipTheme: ChipThemeData(
      backgroundColor: secondaryContainerColor,
      deleteIconColor: onSecondaryContainerColor,
      elevation: 6.0,
      padding: const EdgeInsets.only(left: 6.0),
      labelPadding: const EdgeInsets.only(left: 0, right: 0),
      side: const BorderSide(style: BorderStyle.none),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));

SettingsThemeData lightSettings = SettingsThemeData(
    settingsListBackground: backgroundColor,
    settingsSectionBackground: secondaryContainerColor,
    trailingTextColor: onSecondaryContainerColor,
    dividerColor: onSecondaryContainerColor,
    tileHighlightColor: onSecondaryContainerColor,
    titleTextColor: onSecondaryContainerColor,
    leadingIconsColor: onSecondaryContainerColor,
    tileDescriptionTextColor: onSecondaryContainerColor,
    settingsTileTextColor: onSecondaryContainerColor);
