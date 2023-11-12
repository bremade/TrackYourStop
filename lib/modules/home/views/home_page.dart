import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:track_your_stop/routing/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.train),
              label: AppLocalizations.of(context)!.bottomBarDepartures,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.newspaper),
              label: AppLocalizations.of(context)!.bottomBarNews,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.bottomBarSettings,
            ),
          ],
        );
      },
    );
  }
}
