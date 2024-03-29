import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/database/favorites_database.dart';
import 'package:track_your_stop/modules/favorites/models/favorite.model.dart';
import 'package:track_your_stop/modules/favorites/provider/favorite_list_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/polled_departures_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_destinations_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_origin_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/selected_transportation_types_provider.dart';
import 'package:track_your_stop/modules/favorites/provider/station_controller_provider.dart';
import 'package:track_your_stop/utils/string.util.dart';

class FavoriteAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const FavoriteAppBar({
    Key? key,
  }) : super(key: key);

  void exitContext(WidgetRef ref, BuildContext context) {
    ref.watch(stationControllerProvider).clear();
    ref.invalidate(selectedDestinationsProvider);
    ref.invalidate(selectedTransportationTypesProvider);
    ref.invalidate(selectedOriginProvider);
    ref.invalidate(polledDeparturesProvider);
    context.popRoute();
  }

  void onAddLocationPressed(WidgetRef ref, BuildContext context) {
    final selectedOrigin = ref.watch(selectedOriginProvider);
    final selectedTransportationTypes =
        ref.watch(selectedTransportationTypesProvider);
    final selectedDestinations = ref.watch(selectedDestinationsProvider);
    final selectedDestinationNames =
        selectedDestinations.map((e) => e.destination).toList();

    List<Favorite> toCreate = selectedDestinationNames
        .map((String destination) => Favorite(
            types: convertArrayToString(selectedTransportationTypes),
            origin: selectedOrigin!.name,
            originGlobalId: selectedOrigin.globalId,
            destination: destination,
            labels: selectedDestinations.map((e) => e.label).join(",")))
        .toList();
    FavoritesDatabase.instance.createFavoritesInBatch(toCreate);

    // Refresh favorite provider and therefore main view data
    ref.read(favoriteListProvider.notifier).state =
        FavoritesDatabase.instance.readAll();
    // Delete context when switching back to main view
    exitContext(ref, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.favoriteAppBarTitle),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          exitContext(ref, context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_location),
          tooltip: AppLocalizations.of(context)!.favoriteAppBarAddTooltip,
          onPressed: () => onAddLocationPressed(ref, context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
