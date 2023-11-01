import 'package:track_your_stop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/provider/polled_departures_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_origin_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_transportation_types_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/station_controller_provider.dart';
import 'package:track_your_stop/outbound/interactor/departure_interactor.dart';

TypeAheadField buildTransportationTypeFilterField(
    WidgetRef ref, BuildContext context) {
  TextEditingController transportationTypeController = TextEditingController();

  return TypeAheadField<String>(
      noItemsFoundBuilder: (context) => SizedBox(
          height: 50.0,
          child: Center(
              child: Text(AppLocalizations.of(context)!
                  .favoriteTransportationFilterWait))),
      hideSuggestionsOnKeyboardHide: false,
      hideKeyboardOnDrag: true,
      suggestionsCallback: (input) {
        final selectedStation = ref.watch(selectedOriginProvider);
        if (input == '') {
          return selectedStation == null
              ? const Iterable<String>.empty()
              : selectedStation.transportTypes;
        }

        return selectedStation!.transportTypes
            .map((e) => e.toUpperCase())
            .where((option) => option.contains(input.toUpperCase()));
      },
      onSuggestionSelected: (selection) {
        ref
            .read(selectedTransportationTypesProvider.notifier)
            .addTransportationType(selection);
        ref.watch(stationControllerProvider).text =
            ref.watch(selectedOriginProvider)!.name;
        ref.read(polledDeparturesProvider.notifier).state =
            DepartureInteractor.fetchDeparturesByOriginAndTransportTypes(
                ref.watch(selectedOriginProvider),
                ref.watch(selectedTransportationTypesProvider));
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
            title: Image.asset(getAssetForTransportationType(suggestion),
                height: 20, width: 10));
      },
      textFieldConfiguration: TextFieldConfiguration(
          controller: transportationTypeController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.train),
            labelText:
                AppLocalizations.of(context)!.favoriteTransportationTypeFilter,
          )));
}
