import 'package:track_your_stop/constants/colors.dart';
import 'package:track_your_stop/modules/settings/provider/departure_settings_provider.dart';
import 'package:track_your_stop/modules/settings/ui/slider_selection.dart';
import 'package:track_your_stop/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:track_your_stop/shared/ui/bottom_app_bar.dart';
import 'package:track_your_stop/utils/logger.dart';

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
            title: const Text('Departure count'),
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
                child: const Text('Done'),
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
              title: const Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: const Text('English'),
                ),
                SettingsTile.switchTile(
                  activeSwitchColor:
                      Theme.of(context).toggleButtonsTheme.selectedColor,
                  onToggle: (isActive) => _switchTheme(ref, isActive),
                  initialValue: isDark,
                  leading: Icon(isDark ? Icons.brightness_2 : Icons.wb_sunny),
                  title: const Text('Switch Theme'),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Departures'),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: const Text('Departure Count'),
                  description: const Text(
                      'Defines how manydeparture items per destination are displayed on the start screen.'),
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
