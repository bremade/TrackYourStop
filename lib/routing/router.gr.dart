// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    DepartureRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    NewsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NewsPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    DepartureRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DeparturePage(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const FavoritePage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            RouteConfig(
              DepartureRouter.name,
              path: 'empty-router-page',
              parent: HomeRoute.name,
              children: [
                RouteConfig(
                  DepartureRoute.name,
                  path: '',
                  parent: DepartureRouter.name,
                ),
                RouteConfig(
                  FavoriteRoute.name,
                  path: 'favorite-page',
                  parent: DepartureRouter.name,
                ),
              ],
            ),
            RouteConfig(
              NewsRoute.name,
              path: 'news-page',
              parent: HomeRoute.name,
            ),
            RouteConfig(
              SettingsRoute.name,
              path: 'settings-page',
              parent: HomeRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [EmptyRouterPage]
class DepartureRouter extends PageRouteInfo<void> {
  const DepartureRouter({List<PageRouteInfo>? children})
      : super(
          DepartureRouter.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'DepartureRouter';
}

/// generated route for
/// [NewsPage]
class NewsRoute extends PageRouteInfo<void> {
  const NewsRoute()
      : super(
          NewsRoute.name,
          path: 'news-page',
        );

  static const String name = 'NewsRoute';
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings-page',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [DeparturePage]
class DepartureRoute extends PageRouteInfo<void> {
  const DepartureRoute()
      : super(
          DepartureRoute.name,
          path: '',
        );

  static const String name = 'DepartureRoute';
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute()
      : super(
          FavoriteRoute.name,
          path: 'favorite-page',
        );

  static const String name = 'FavoriteRoute';
}
