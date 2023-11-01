import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:settings_ui/settings_ui.dart";
import "package:track_your_stop/utils/app_theme.dart";
import "package:track_your_stop/utils/logger.dart";

final logger = getLogger("CommonSettingsSection");

SettingsSection buildCommonSettingsSection(
    BuildContext context, WidgetRef ref) {
  final bool isDark = ref.watch(themeProvider) == ThemeMode.dark;
  return SettingsSection(
    title: Text(AppLocalizations.of(context)!.settingsSectionCommon),
    tiles: <SettingsTile>[
      SettingsTile(
        leading: const Icon(Icons.language),
        title: Text(AppLocalizations.of(context)!.settingsLanguageTitle),
        value: Text(AppLocalizations.of(context)!.settingsLanguageValue),
      ),
      SettingsTile.switchTile(
        activeSwitchColor: Theme.of(context).toggleButtonsTheme.selectedColor,
        onToggle: (isActive) => switchTheme(ref, isActive),
        initialValue: isDark,
        leading: Icon(isDark ? Icons.brightness_2 : Icons.wb_sunny),
        title: Text(AppLocalizations.of(context)!.settingsThemeSwitchTitle),
      ),
    ],
  );
}
