import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/settings/provider/departure_settings_provider.dart';

class SliderSelection extends StatefulWidget {
  final WidgetRef ref;

  const SliderSelection({required this.ref, Key? key}) : super(key: key);

  @override
  SliderSelectionState createState() => SliderSelectionState();
}

class SliderSelectionState extends State<SliderSelection> {
  // ignore: unused_field
  double _sliderValue = 1;

  Widget _getSlider(BuildContext context) {
    double globalCounterState =
        widget.ref.watch(departureSettingsProvider).toDouble();
    return Slider(
      value: globalCounterState,
      min: 1,
      max: 3,
      divisions: 2,
      label: globalCounterState.toInt().toString(),
      onChanged: (double value) {
        setState(() {
          _sliderValue = value;
        });
        widget.ref.read(departureSettingsProvider.notifier).state =
            value.toInt();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getSlider(context),
      ],
    );
  }
}

Future showSliderDialog(BuildContext context, WidgetRef ref) => showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context)!.settingsDepartureCountSliderTitle),
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
