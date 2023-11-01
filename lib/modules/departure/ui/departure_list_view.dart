import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/departure/ui/departure_card.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';

ListView buildListView(WidgetRef ref, BuildContext context,
    Map<String, List<DepartureResponse>> stationMap) {
  final List<String> stationNames = stationMap.keys.toList();
  List<Widget> stationCards = <Widget>[];
  for (var stationName in stationNames) {
    final stationDepartures = stationMap[stationName];
    if (stationDepartures != null) {
      final List<DepartureResponse> departures = stationDepartures;
      departures.sort(
          (a, b) => a.realtimeDepartureTime.compareTo(b.realtimeDepartureTime));
      stationCards.add(
        // Add station name as divider
        Container(
          padding: const EdgeInsets.only(top: 5.0, left: 20.0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              stationName,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      );
      for (var stationDeparture in departures) {
        stationCards.add(buildCard(
            ref,
            stationDeparture.transportType,
            stationName,
            stationDeparture.destination,
            stationDeparture.realtimeDepartureTime));
      }
      if (stationName != stationNames.last) {
        stationCards.add(const Divider(
          indent: 10.0,
          endIndent: 10.0,
          thickness: 2,
        ));
      }
    }
  }
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: stationCards,
  );
}
