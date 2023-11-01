import 'package:track_your_stop/modules/home/views/home_page.dart';
import 'package:track_your_stop/modules/news/views/news_page.dart';
import 'package:track_your_stop/modules/settings/views/settings_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:track_your_stop/modules/departure/views/departure_page.dart';
import 'package:track_your_stop/modules/favorites/views/favorite_page.dart';

part 'router.gr.dart';

@EmptyRouterPage()
class EmptyRouterPage extends AutoRouter {
  const EmptyRouterPage({super.key});
}

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
    page: HomePage,
    initial: true,
    children: [
      AutoRoute(
        name: 'DepartureRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(path: '', page: DeparturePage),
          AutoRoute(page: FavoritePage),
        ],
      ),
      AutoRoute(page: NewsPage),
      AutoRoute(page: SettingsPage),
    ],
  )
])
class AppRouter extends _$AppRouter {}
