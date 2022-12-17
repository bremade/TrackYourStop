import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mvv_tracker/modules/departure/view/departure_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: DeparturePage, initial: true),
  ],
)
class AppRouter extends _$AppRouter{}