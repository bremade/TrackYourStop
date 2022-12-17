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
    DepartureRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DeparturePage(),
      );
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          DepartureRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [DeparturePage]
class DepartureRoute extends PageRouteInfo<void> {
  const DepartureRoute()
      : super(
          DepartureRoute.name,
          path: '/',
        );

  static const String name = 'DepartureRoute';
}
