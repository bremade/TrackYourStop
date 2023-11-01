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
  _setUiStyle(themeMode);
  return themeMode;
});

void _setUiStyle(final ThemeMode configuredMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: configuredMode == ThemeMode.dark
          ? DarkThemeColors.secondaryContainerColor
          : LightThemeColors.secondaryContainerColor,
      systemNavigationBarColor: configuredMode == ThemeMode.dark
          ? DarkThemeColors.secondaryContainerColor
          : LightThemeColors.secondaryContainerColor));
}

void switchTheme(WidgetRef ref, bool isActive) {
  final ThemeMode theme = isActive ? ThemeMode.dark : ThemeMode.light;
  _setUiStyle(theme);
  ref.read(themeProvider.notifier).state = theme;
}

ThemeData createTheme(
    Brightness brightness,
    ColorScheme colorScheme,
    Color secondaryContainerColor,
    Color onSecondaryContainerColor,
    Color primaryColor) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
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
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(selectedColor: primaryColor),
  );
}

SettingsThemeData createSettingsTheme(
    Color settingsListBackground,
    Color settingsSectionBackground,
    Color trailingTextColor,
    Color dividerColor,
    Color tileHighlightColor,
    Color titleTextColor,
    Color leadingIconsColor,
    Color tileDescriptionTextColor,
    Color settingsTileTextColor) {
  return SettingsThemeData(
    settingsListBackground: settingsListBackground,
    settingsSectionBackground: settingsSectionBackground,
    trailingTextColor: trailingTextColor,
    dividerColor: dividerColor,
    tileHighlightColor: tileHighlightColor,
    titleTextColor: titleTextColor,
    leadingIconsColor: leadingIconsColor,
    tileDescriptionTextColor: tileDescriptionTextColor,
    settingsTileTextColor: settingsTileTextColor,
  );
}

/////////////////////////////////////
///          Light Theme          ///
/////////////////////////////////////
ThemeData lightTheme = createTheme(
    Brightness.light,
    ColorScheme.fromSeed(seedColor: GlobalColors.themeSeed),
    LightThemeColors.secondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.primaryColor);
SettingsThemeData lightSettings = createSettingsTheme(
    LightThemeColors.backgroundColor,
    LightThemeColors.secondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor,
    LightThemeColors.onSecondaryContainerColor);

/////////////////////////////////////
///           Dark Theme          ///
/////////////////////////////////////
ThemeData darkTheme = createTheme(
    Brightness.dark,
    ColorScheme.fromSeed(
        seedColor: GlobalColors.themeSeed, brightness: Brightness.dark),
    DarkThemeColors.secondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.primaryColor);
SettingsThemeData darkSettings = createSettingsTheme(
    DarkThemeColors.backgroundColor,
    DarkThemeColors.secondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor,
    DarkThemeColors.onSecondaryContainerColor);
