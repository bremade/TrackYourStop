import 'dart:collection';

import 'package:TrackYourStop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/constants/colors.dart';
import 'package:TrackYourStop/constants/departure_card_choices.dart';
import 'package:TrackYourStop/modules/departure/control/departure_control.dart';
import 'package:TrackYourStop/modules/favorites/database/favorites_database.dart';
import 'package:TrackYourStop/modules/favorites/models/favorite.model.dart';
import 'package:TrackYourStop/modules/favorites/provider/favorite_list_provider.dart';
import 'package:TrackYourStop/modules/departure/ui/create_favorite_fab.dart';
import 'package:TrackYourStop/modules/departure/ui/departure_card.dart';
import 'package:TrackYourStop/outbound/models/departure_response.dart';
import 'package:TrackYourStop/shared/ui/bottom_app_bar.dart';
import 'package:TrackYourStop/utils/arrival_accent.util.dart';
import 'package:TrackYourStop/utils/logger.dart';

final logger = getLogger("DeparturePage");

class DeparturePage extends HookConsumerWidget {
  const DeparturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void choiceAction(String choice, String origin, String destination) {
      switch (choice) {
        case DepartureCardChoices.remove:
          FavoritesDatabase.instance.deleteDestination(origin, destination);
          // Refresh favorite provider and therefore main view data
          ref.read(favoriteListProvider.notifier).state =
              FavoritesDatabase.instance.readAll();
      }
    }

    Card buildCard(String transportType, String origin, String destination,
            int arrivalTime) =>
        Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
              decoration: BoxDecoration(
                  color: darkPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1.5, color: Colors.white24))),
                      // TODO TYS-3
                      child: Image.asset(
                          getAssetForTransportationType(transportType),
                          height: 25,
                          width: 50)),
                  title: Text(
                        destination,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale,
                          color: getAccentColorForTime(arrivalTime)),
                      Text(" $arrivalTime min",
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return DepartureCardChoices.choices
                            .map((String choice) {
                          return PopupMenuItem(
                              value: choice, child: Text(choice));
                        }).toList();
                      },
                      onSelected: (choice) =>
                          choiceAction(choice, origin, destination)))),
        );

    ListView buildListView(
        BuildContext context, Map<String, List<DepartureResponse>> stationMap) {
      final List<String> stationNames = stationMap.keys.toList();
      List<Widget> stationCards = <Widget>[];
      for (var stationName in stationNames) {
        final stationDepartures = stationMap[stationName];
        if (stationDepartures != null) {
          final List<DepartureResponse> departures = stationDepartures;
          departures.sort((a, b) =>
              a.realtimeDepartureTime.compareTo(b.realtimeDepartureTime));
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
            logger.d(stationDeparture.toJson());
            stationCards.add(buildCard(
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

    Widget buildBody() {
      // Retrieve favorites from database
      Future<List<Favorite>> favorites = ref.watch(favoriteListProvider);
      // Build map that maps origin station maps to its departures
      Future<HashMap<String, List<DepartureResponse>>> stationMapFuture =
          buildStationMap(favorites);
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
                    return const Center(
                        child: Text("No stations defined yet."));
                  }
                  return buildListView(context, stationMap);
                }
            }
          });
    }

    return Scaffold(
      body: RefreshIndicator(
        child: buildBody(),
        onRefresh: () {
          // Refresh favorite provider and therefore main view data
          return ref.read(favoriteListProvider.notifier).state =
              FavoritesDatabase.instance.readAll();
        },
      ),
      floatingActionButton: const CreateFavoriteFab(),
      bottomNavigationBar: BottomAppNavigationBar(),
    );
  }
}
