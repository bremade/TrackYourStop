import 'package:track_your_stop/outbound/interactor/station_interactor.dart';
import 'package:track_your_stop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/provider/polled_departures_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_origin_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_transportation_types_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/station_controller_provider.dart';
import 'package:track_your_stop/outbound/interactor/departure_interactor.dart';
import 'package:track_your_stop/outbound/models/station_response.dart';

TypeAheadField buildStationSelectionField(WidgetRef ref, BuildContext context) {
  return TypeAheadField<StationResponse?>(
    noItemsFoundBuilder: (context) => SizedBox(
        height: 50.0,
        child: Center(
            child: Text(
                AppLocalizations.of(context)!.favoriteOriginSelectionError))),
    hideSuggestionsOnKeyboardHide: false,
    hideKeyboardOnDrag: true,
    debounceDuration: const Duration(milliseconds: 1000),
    suggestionsCallback: StatusInteractor.getStationSuggestions,
    itemBuilder: (context, StationResponse? suggestion) {
      final stationResponse = suggestion!;
      final List<ImageProvider> transportationTypeAssets =
          getAssetListForTransportationType(stationResponse.transportTypes,
              charOnly: true);
      return ListTile(
          title: Text(stationResponse.name),
          leading: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 10,
                maxWidth: 50,
                minHeight: 20,
                maxHeight: 100,
              ),
              child: FlutterImageStack.providers(
                providers: transportationTypeAssets,
                totalCount: transportationTypeAssets.length,
                itemCount: transportationTypeAssets.length,
                itemBorderWidth: 1,
              )));
    },
    textFieldConfiguration: TextFieldConfiguration(
        controller: ref.watch(stationControllerProvider),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
          labelText: AppLocalizations.of(context)!.favoriteOriginSelectionLabel,
        )),
    onSuggestionSelected: (StationResponse? selection) {
      ref.read(selectedOriginProvider.notifier).state = selection!;
      ref.watch(stationControllerProvider).text = selection.name;
      ref.read(polledDeparturesProvider.notifier).state =
          DepartureInteractor.fetchDeparturesByOriginAndTransportTypes(
              ref.watch(selectedOriginProvider),
              TransportationTypeEnum.values.map((e) => e.name).toList());
    },
  );
}
