import 'package:track_your_stop/modules/favorites/provider/selected_destinations_provider.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';
import 'package:track_your_stop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/provider/polled_departures_provider.dart';

// Add/Remove departure response to state
void _onDestinationSelected(
    WidgetRef ref, bool selected, DepartureResponse departure) {
  if (selected == true) {
    ref.read(selectedDestinationsProvider.notifier).addDestination(departure);
  } else {
    ref
        .read(selectedDestinationsProvider.notifier)
        .removeDestination(departure);
  }
}

FutureBuilder buildDestinationListView(WidgetRef ref) {
  return FutureBuilder(
    future: ref.watch(polledDeparturesProvider),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<DepartureResponse> departures = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: departures.length,
              itemBuilder: (BuildContext context, int index) {
                final List<DepartureResponse> selectedDestinations =
                    ref.watch(selectedDestinationsProvider);
                return CheckboxListTile(
                    value: selectedDestinations.contains(departures[index]),
                    onChanged: (bool? selected) {
                      _onDestinationSelected(ref, selected!, departures[index]);
                    },
                    title: Text(departures[index].destination),
                    secondary: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          maxWidth: 50,
                          minHeight: 20,
                          maxHeight: 100,
                        ),
                        child: Image.asset(getAssetForTransportationType(
                            departures[index].transportType))));
              },
            );
          }
      }
    },
  );
}
