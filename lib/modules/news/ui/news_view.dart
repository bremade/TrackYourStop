import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/news/ui/news_card.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';

ListView buildListView(
    WidgetRef ref, BuildContext context, List<NewsResponse> newsList) {
  return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: newsList.map((news) {
      return buildCard(
          ref, context, news.type == "DISRUPTION", news.title, news.lines);
    }).toList(),
  );
}
