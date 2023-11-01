import 'package:track_your_stop/modules/favorites/ui/destination_list_view.dart';
import 'package:track_your_stop/modules/favorites/ui/station_selection_field.dart';
import 'package:track_your_stop/modules/favorites/ui/transport_type_chips.dart';
import 'package:track_your_stop/modules/favorites/ui/transport_type_filter_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/ui/favorite_app_bar.dart';

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildBody() {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 32.0, right: 32.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // Station selection autocomplete field
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: buildStationSelectionField(ref, context)),
                // Transportation type filter autocomplete field
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: buildTransportationTypeFilterField(ref, context)),
                // Chip list containing selected transportation types
                Container(
                    height: 50.0,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    // Save selected chips to state
                    child: buildChips(ref)),
                // Destination divider
                const Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 2,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    AppLocalizations.of(context)!.favoriteDestinationSelection,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                // Future list view for destinations according to selected origin and transportation types
                Expanded(child: buildDestinationListView(ref))
              ],
            )),
      );
    }

    return Scaffold(
      appBar: const FavoriteAppBar(),
      body: Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) =>
            buildBody(),
      ),
    );
  }
}
