import 'package:track_your_stop/modules/news/views/news_page.dart';
import 'package:track_your_stop/modules/settings/views/settings_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:track_your_stop/modules/departure/views/departure_page.dart';
import 'package:track_your_stop/modules/favorites/views/favorite_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: DeparturePage, initial: true),
    AutoRoute(page: FavoritePage),
    AutoRoute(page: NewsPage),
    AutoRoute(page: SettingsPage)
  ],
)
class AppRouter extends _$AppRouter {}
