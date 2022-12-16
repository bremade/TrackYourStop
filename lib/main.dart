// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mvv_tracker/routing/router.dart';
import 'package:mvv_tracker/routing/tab_navigation_observer.dart';
import 'package:mvv_tracker/shared/provider/app_state.provider.dart';
import 'package:mvv_tracker/utils/logger.util.dart';
import 'package:mvv_tracker/utils/app_theme.dart';

void main() {
  Logger.level = Level.debug;
  runApp(const ProviderScope(
      child: HaltestellenTrackerApp()
  ));
}

class HaltestellenTrackerApp extends ConsumerStatefulWidget {
  const HaltestellenTrackerApp({super.key});

  @override
  HaltestellenTrackerState createState() => HaltestellenTrackerState();
}

class HaltestellenTrackerState extends ConsumerState<HaltestellenTrackerApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("[APP STATE] resumed");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.resumed;
        break;
      case AppLifecycleState.inactive:
        debugPrint("[APP STATE] inactive");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.inactive;
        break;
      case AppLifecycleState.paused:
        debugPrint("[APP STATE] paused");
        ref.watch(appStateProvider.notifier).state = AppStateEnum.paused;
        break;
      case AppLifecycleState.detached:
        debugPrint("[APP STATE] detached");
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
    initApp().then((_) => debugPrint("App Init Completed"));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _router = AppRouter();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          MaterialApp.router(
            title: 'Haltestellen Tracker',
            debugShowCheckedModeBanner: false,
            themeMode: ref.watch(immichThemeProvider),
            darkTheme: immichDarkTheme,
            theme: immichLightTheme,
            routeInformationParser: _router.defaultRouteParser(),
            routerDelegate: _router.delegate(
              navigatorObservers: () => [TabNavigationObserver(ref: ref)],
            ),
          ),
        ],
      ),
    );
  }
}
