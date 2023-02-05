import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:TrackYourStop/modules/departure/views/departure_page.dart';
import 'package:TrackYourStop/modules/favorites/views/favorite_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: DeparturePage, initial: true),
    AutoRoute(page: FavoritePage),
  ],
)
class AppRouter extends _$AppRouter{}