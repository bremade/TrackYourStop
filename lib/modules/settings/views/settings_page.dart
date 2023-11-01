import "package:track_your_stop/modules/settings/ui/common_section.dart";
import "package:track_your_stop/modules/settings/ui/departure_section.dart";
import "package:track_your_stop/modules/settings/ui/news_section.dart";
import "package:track_your_stop/utils/app_theme.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:settings_ui/settings_ui.dart";
import "package:track_your_stop/shared/ui/bottom_app_bar.dart";

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildSettings(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SettingsList(
          darkTheme: darkSettings,
          lightTheme: lightSettings,
          sections: [
            buildCommonSettingsSection(context, ref),
            buildDepartureSettingsSection(context, ref),
            buildNewsSettingsSection(context, ref)
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      body: _buildSettings(context, ref),
      bottomNavigationBar: const BottomAppNavigationBar(),
    );
  }
}
