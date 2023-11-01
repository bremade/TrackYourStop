import 'package:track_your_stop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/provider/polled_departures_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_origin_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_transportation_types_provider.dart';
import 'package:track_your_stop/outbound/interactor/departure_interactor.dart';

Widget buildChips(WidgetRef ref) {
  List<Widget> chips = [];
  final List<String> selectedTransportationTypes =
      ref.watch(selectedTransportationTypesProvider);
  for (var transportType in selectedTransportationTypes) {
    InputChip actionChip = InputChip(
      label: const Text(""),
      avatar: Container(
          width: 35.0,
          height: 17.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage(getAssetForTransportationType(
                      transportType.toUpperCase()))))),
      deleteIcon: const Icon(Icons.remove_circle),
      onDeleted: () {
        ref
            .read(selectedTransportationTypesProvider.notifier)
            .removeTransportationType(transportType);
        ref.read(polledDeparturesProvider.notifier).state =
            DepartureInteractor.fetchDeparturesByOriginAndTransportTypes(
                ref.watch(selectedOriginProvider),
                ref.watch(selectedTransportationTypesProvider));
      },
    );
    chips.add(actionChip);
  }
  return ListView.builder(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      itemCount: chips.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 5.0), child: chips[index]));
}
