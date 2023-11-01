import 'dart:collection';

import 'package:track_your_stop/modules/departure/ui/departure_list_view.dart';
import 'package:track_your_stop/modules/settings/provider/departure_settings_provider.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/departure/control/departure_control.dart';
import 'package:track_your_stop/modules/favorites/database/favorites_database.dart';
import 'package:track_your_stop/modules/favorites/models/favorite.model.dart';
import 'package:track_your_stop/modules/favorites/provider/favorite_list_provider.dart';
import 'package:track_your_stop/modules/departure/ui/create_favorite_fab.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';

class DeparturePage extends HookConsumerWidget {
  const DeparturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildBody() {
      // Retrieve favorites from database
      Future<List<Favorite>> favorites = ref.watch(favoriteListProvider);
      int departureCountSetting = ref.watch(departureSettingsProvider);
      // Build map that maps origin station maps to its departures
      Future<HashMap<String, List<DepartureResponse>>> stationMapFuture =
          buildStationMap(favorites, departureCountSetting);
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
                    return Center(
                        child: Text(
                            AppLocalizations.of(context)!.departureEmptyText));
                  }
                  return buildListView(ref, context, stationMap);
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
        floatingActionButton: const CreateFavoriteFab());
  }
}
