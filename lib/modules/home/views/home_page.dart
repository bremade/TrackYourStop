import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:track_your_stop/routing/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DepartureRouter(),
        NewsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
                label: 'Departures', icon: Icon(Icons.train)),
            BottomNavigationBarItem(label: 'News', icon: Icon(Icons.newspaper)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings)),
          ],
        );
      },
    );
  }
}
