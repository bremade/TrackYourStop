import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:settings_ui/settings_ui.dart";
import "package:track_your_stop/modules/settings/provider/departure_settings_provider.dart";
import "package:track_your_stop/modules/settings/ui/slider_selection.dart";
import "package:track_your_stop/utils/logger.dart";

final logger = getLogger("DepartureSettingsSection");

SettingsSection buildDepartureSettingsSection(
    BuildContext context, WidgetRef ref) {
  return SettingsSection(
    title: Text(AppLocalizations.of(context)!.settingsSectionDeparture),
    tiles: <SettingsTile>[
      SettingsTile(
        title: Text(AppLocalizations.of(context)!.settingsDepartureCountTitle),
        description: Text(
            AppLocalizations.of(context)!.settingsDepartureCountDescription),
        value: Text(ref.watch(departureSettingsProvider).toString()),
        leading: const Icon(Icons.train),
        onPressed: (BuildContext context) {
          showSliderDialog(context, ref);
        },
      ),
    ],
  );
}
