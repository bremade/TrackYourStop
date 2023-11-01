import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/constants/colors.dart';
import 'package:track_your_stop/modules/news/entity/news_card_data.dart';
import 'package:track_your_stop/outbound/models/news_line.dart';
import 'package:track_your_stop/utils/app_theme.dart';
import 'package:track_your_stop/utils/transportation_type.util.dart';

Card _buildCard(NewsCardData data) {
  return Card(
    elevation: 0.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
        color: data.containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildListTile(data),
    ),
  );
}

ListTile _buildListTile(NewsCardData data) {
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
          right: BorderSide(width: 1.5, color: data.textColor),
        ),
      ),
      child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 10,
            maxWidth: 50,
            minHeight: 20,
            maxHeight: 100,
          ),
          child: FlutterImageStack.providers(
            providers: data.transportationTypeAssets,
            totalCount: data.transportationTypeAssets.length,
            itemCount: data.transportationTypeAssets.length,
            itemBorderWidth: 1,
          )),
    ),
    title: Text(
      data.urgent
          ? "${AppLocalizations.of(data.context)!.newsUrgent}: ${data.title}"
          : "${AppLocalizations.of(data.context)!.newsPlanned}: ${data.title}",
      style: TextStyle(
        color: data.textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      data.lines.map((e) => e.name).toSet().join(", "),
    ),
  );
}

Card buildCard(WidgetRef ref, BuildContext context, bool urgent, String title,
    List<NewsLine> lines) {
  final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
  var containerColor = isDarkMode
      ? DarkThemeColors.secondaryContainerColor
      : LightThemeColors.secondaryContainerColor;
  if (urgent) {
    containerColor = isDarkMode
        ? DarkThemeColors.tertiaryContainerColor
        : LightThemeColors.tertiaryContainerColor;
  }
  final textColor = isDarkMode
      ? DarkThemeColors.onSecondaryContainerColor
      : LightThemeColors.onSecondaryContainerColor;
  final List<ImageProvider> transportationTypeAssets =
      getAssetListForTransportationType(
          lines.map((e) => e.typeOfTransport).toSet(),
          charOnly: true);
  return _buildCard(NewsCardData(
    context: context,
    urgent: urgent,
    title: title,
    lines: lines,
    containerColor: containerColor,
    textColor: textColor,
    transportationTypeAssets: transportationTypeAssets,
  ));
}
