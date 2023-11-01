import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/constants/colors.dart';
import 'package:track_your_stop/constants/departure_card_choices.dart';
import 'package:track_your_stop/modules/favorites/database/favorites_database.dart';
import 'package:track_your_stop/modules/favorites/provider/favorite_list_provider.dart';
import 'package:track_your_stop/utils/app_theme.dart';
import 'package:track_your_stop/utils/arrival_accent.util.dart';
import 'package:track_your_stop/utils/transportation_type.util.dart';

void _choiceAction(
    WidgetRef ref, String choice, String origin, String destination) {
  switch (choice) {
    case DepartureCardChoices.remove:
      FavoritesDatabase.instance.deleteDestination(origin, destination);
      // Refresh favorite provider and therefore main view data
      ref.read(favoriteListProvider.notifier).state =
          FavoritesDatabase.instance.readAll();
  }
}

ListTile _buildCardListTile(WidgetRef ref, bool isDarkMode, transportType,
    String origin, String destination, int arrivalTime) {
  final textColor = isDarkMode
      ? DarkThemeColors.onSecondaryContainerColor
      : LightThemeColors.onSecondaryContainerColor;
  final accentColor = getAccentColorForTime(arrivalTime);

  return ListTile(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 10.0,
    ),
    leading: Container(
      height: double.infinity,
      padding: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.5, color: textColor),
        ),
      ),
      child: Image.asset(
        getAssetForTransportationType(transportType),
        height: 25,
        width: 50,
      ),
    ),
    title: Text(
      destination,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Row(
      children: <Widget>[
        Icon(
          Icons.linear_scale,
          color: accentColor,
        ),
        Text(
          " $arrivalTime min",
          style: TextStyle(color: textColor),
        ),
      ],
    ),
    trailing: PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return DepartureCardChoices.choices.map((String choice) {
          return PopupMenuItem(value: choice, child: Text(choice));
        }).toList();
      },
      onSelected: (choice) => _choiceAction(ref, choice, origin, destination),
    ),
  );
}

Card buildCard(WidgetRef ref, transportType, String origin, String destination,
    int arrivalTime) {
  final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
  final containerColor = isDarkMode
      ? DarkThemeColors.secondaryContainerColor
      : LightThemeColors.secondaryContainerColor;

  return Card(
    elevation: 0.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: _buildCardListTile(
            ref, isDarkMode, transportType, origin, destination, arrivalTime)),
  );
}
