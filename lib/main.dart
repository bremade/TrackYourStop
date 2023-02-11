// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:TrackYourStop/modules/favorites/database/favorites_database.dart';
import 'package:TrackYourStop/modules/favorites/models/favorite.model.dart';
import 'package:TrackYourStop/modules/favorites/ui/favorite_app_bar.dart';
import 'package:TrackYourStop/routing/router.dart';
import 'package:TrackYourStop/routing/tab_navigation_observer.dart';
import 'package:TrackYourStop/shared/provider/app_state.provider.dart';
import 'package:TrackYourStop/utils/app_theme.dart';
import 'package:TrackYourStop/utils/logger.dart';

final logger = getLogger("Main");
final _appRouter = AppRouter();

void main() async {
  Logger.level = Level.debug;
  runApp(const ProviderScope(child: HaltestellenTrackerApp()));
}

class HaltestellenTrackerApp extends ConsumerStatefulWidget {
  const HaltestellenTrackerApp({super.key});

  @override
  HaltestellenTrackerState createState() => HaltestellenTrackerState();
}

class HaltestellenTrackerState extends ConsumerState<HaltestellenTrackerApp>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        logger.d("[APP STATE] resumed");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.resumed;
        break;
      case AppLifecycleState.inactive:
        logger.d("[APP STATE] inactive");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.inactive;
        break;
      case AppLifecycleState.paused:
        logger.d("[APP STATE] paused");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.paused;
        break;
      case AppLifecycleState.detached:
        logger.d("[APP STATE] detached");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.detached;
        break;
    }
  }

  Future<void> initApp() async {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  initState() {
    super.initState();
    initApp().then((_) => logger.d("App Init Completed"));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Haltestellen Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider),
      darkTheme: darkTheme,
      theme: lightTheme,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [TabNavigationObserver(ref: ref)],
      ),
    );
  }
}
