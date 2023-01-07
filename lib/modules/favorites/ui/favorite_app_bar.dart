import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/modules/favorites/database/favorites_database.dart';
import 'package:mvv_tracker/modules/favorites/models/favorite.model.dart';
import 'package:mvv_tracker/modules/favorites/provider/favorite_list_provider.dart';
import 'package:mvv_tracker/modules/favorites/provider/polled_departures_provider.dart';
import 'package:mvv_tracker/modules/favorites/provider/selected_destinations_provider.dart';
import 'package:mvv_tracker/modules/favorites/provider/selected_origin_provider.dart';
import 'package:mvv_tracker/modules/favorites/provider/selected_transportation_types_provider.dart';
import 'package:mvv_tracker/modules/favorites/provider/station_controller_provider.dart';
import 'package:mvv_tracker/utils/logger.dart';
import 'package:mvv_tracker/utils/string.util.dart';

class FavoriteAppBar extends ConsumerWidget with PreferredSizeWidget {
  FavoriteAppBar({
    Key? key,
  }) : super(key: key);

  final logger = getLogger("BottomAppBar");

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void exitContext() {
      ref.watch(stationControllerProvider).clear();
      ref.invalidate(selectedDestinationsProvider);
      ref.invalidate(selectedTransportationTypesProvider);
      ref.invalidate(selectedOriginProvider);
      ref.invalidate(polledDeparturesProvider);
      context.navigateBack();
    }

    return AppBar(
      title: const Text('Add favorite'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          exitContext();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_location),
          tooltip: 'Add favorite station',
          onPressed: () {
            final selectedOrigin = ref.watch(selectedOriginProvider);
            final selectedTransportationTypes =
                ref.watch(selectedTransportationTypesProvider);
            final selectedDestinations =
                ref.watch(selectedDestinationsProvider);
            final selectedDestinationNames =
                selectedDestinations.map((e) => e.destination).toList();

            FavoritesDatabase.instance.create(Favorite(
                origin: selectedOrigin!.name,
                originGlobalId: selectedOrigin.globalId,
                types: convertArrayToString(selectedTransportationTypes),
                destinations: convertArrayToString(selectedDestinationNames)));

            // Refresh favorite provider and therefore main view data
            ref.read(favoriteListProvider.notifier).state = FavoritesDatabase.instance.readAll();
            // Delete context when switching back to main view
            exitContext();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
