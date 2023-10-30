import "package:track_your_stop/modules/settings/provider/departure_settings_provider.dart";
import "package:track_your_stop/modules/settings/ui/slider_selection.dart";
import "package:track_your_stop/utils/app_theme.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:settings_ui/settings_ui.dart";
import "package:track_your_stop/shared/ui/bottom_app_bar.dart";
import "package:track_your_stop/utils/logger.dart";

final logger = getLogger("SettingsPage");

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _switchTheme(WidgetRef ref, bool isActive) {
    final ThemeMode theme = isActive ? ThemeMode.dark : ThemeMode.light;
    setUiStyle(theme);
    ref.read(themeProvider.notifier).state = theme;
  }

  Future _showSliderDialog(BuildContext context, WidgetRef ref) =>
      showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!
                .settingsDepartureCountSliderTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SliderSelection(ref: ref),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.dialogDone),
              ),
            ],
          );
        },
      );

  Widget _buildSettings(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeProvider) == ThemeMode.dark;
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SettingsList(
          darkTheme: darkSettings,
          lightTheme: lightSettings,
          sections: [
            SettingsSection(
              title: Text(AppLocalizations.of(context)!.settingsSectionCommon),
              tiles: <SettingsTile>[
                SettingsTile(
                  leading: const Icon(Icons.language),
                  title:
                      Text(AppLocalizations.of(context)!.settingsLanguageTitle),
                  value:
                      Text(AppLocalizations.of(context)!.settingsLanguageValue),
                ),
                SettingsTile.switchTile(
                  activeSwitchColor:
                      Theme.of(context).toggleButtonsTheme.selectedColor,
                  onToggle: (isActive) => _switchTheme(ref, isActive),
                  initialValue: isDark,
                  leading: Icon(isDark ? Icons.brightness_2 : Icons.wb_sunny),
                  title: Text(
                      AppLocalizations.of(context)!.settingsThemeSwitchTitle),
                ),
              ],
            ),
            SettingsSection(
              title:
                  Text(AppLocalizations.of(context)!.settingsSectionDeparture),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: Text(AppLocalizations.of(context)!
                      .settingsDepartureCountTitle),
                  description: Text(AppLocalizations.of(context)!
                      .settingsDepartureCountDescription),
                  value: Text(ref.watch(departureSettingsProvider).toString()),
                  leading: const Icon(Icons.train),
                  onPressed: (BuildContext context) {
                    _showSliderDialog(context, ref);
                  },
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      body: _buildSettings(context, ref),
      bottomNavigationBar: BottomAppNavigationBar(),
    );
  }
}
