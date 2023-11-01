import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:settings_ui/settings_ui.dart";
import "package:track_your_stop/modules/settings/provider/news_settings_provider.dart";

SettingsSection buildNewsSettingsSection(BuildContext context, WidgetRef ref) {
  final bool isNewsFiltered = ref.watch(newsSettingsFilterProvider);
  final bool fetchAllNews = ref.watch(newsSettingsFetchAllProvider);
  return SettingsSection(
    title: Text(AppLocalizations.of(context)!.settingsSectionNews),
    tiles: <SettingsTile>[
      SettingsTile.switchTile(
        activeSwitchColor: Theme.of(context).toggleButtonsTheme.selectedColor,
        onToggle: (isActive) {
          ref.watch(newsSettingsFetchAllProvider.notifier).state = isActive;
        },
        initialValue: fetchAllNews,
        leading: const Icon(Icons.filter_alt),
        title: Text(AppLocalizations.of(context)!.settingsNewsFetchAllTitle),
        description:
            Text(AppLocalizations.of(context)!.settingsNewsFetchAllDescription),
      ),
      SettingsTile.switchTile(
        activeSwitchColor: Theme.of(context).toggleButtonsTheme.selectedColor,
        onToggle: (isActive) {
          ref.watch(newsSettingsFilterProvider.notifier).state = isActive;
        },
        initialValue: isNewsFiltered,
        leading: const Icon(Icons.filter_alt),
        title: Text(AppLocalizations.of(context)!.settingsNewsFilterTitle),
        description:
            Text(AppLocalizations.of(context)!.settingsNewsFilterDescription),
      ),
    ],
  );
}
