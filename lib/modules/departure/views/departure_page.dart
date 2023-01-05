import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/modules/departure/control/departure_control.dart';
import 'package:mvv_tracker/modules/favorites/models/favorite.model.dart';
import 'package:mvv_tracker/modules/favorites/provider/favorite_list_provider.dart';
import 'package:mvv_tracker/modules/departure/ui/create_favorite_fab.dart';
import 'package:mvv_tracker/modules/departure/ui/departure_card.dart';
import 'package:mvv_tracker/outbound/models/departure_response.dart';
import 'package:mvv_tracker/shared/ui/bottom_app_bar.dart';
import 'package:mvv_tracker/utils/logger.dart';

final logger = getLogger("DeparturePage");

class DeparturePage extends HookConsumerWidget {
  const DeparturePage({Key? key}) : super(key: key);

  ListView buildListView(
      BuildContext context, Map<String, List<DepartureResponse>> stationMap) {
    final List<String> stationNames = stationMap.keys.toList();
    List<Widget> stationCards = <Widget>[];
    for (var stationName in stationNames) {
      final stationDepartures = stationMap[stationName];
      if (stationDepartures != null) {
        stationCards.add(
          // Add station name as divider
          Container(
            padding: const EdgeInsets.only(left: 20),
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
        for (var stationDeparture in stationDepartures) {
          logger.i(stationDeparture.toJson());
          stationCards.add(buildCard(Icons.train, stationDeparture.destination,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildBody() {
      Future<List<Favorite>> favorites = ref.watch(favoriteListProvider);
      Future<HashMap<String, List<DepartureResponse>>> stationMapFuture =
          buildStationMap(favorites);
      // Wenn x milliseconds keine eingabe dann anfragen
      return FutureBuilder(
          future: stationMapFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final Map<String, List<DepartureResponse>> stationMap =
                      Map.from(snapshot.data);
                  if (stationMap.isEmpty) {
                    return const Center(child: Text("TEST"));
                  }
                  return buildListView(context, stationMap);
                }
            }
          });
    }

    return Scaffold(
      body: buildBody(),
      floatingActionButton: const CreateFavoriteFab(),
      bottomNavigationBar: BottomAppNavigationBar(),
    );
  }
}
