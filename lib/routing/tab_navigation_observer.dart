import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/provider/favorite_list_provider.dart';

class TabNavigationObserver extends AutoRouterObserver {
  /// Riverpod Instance
  final WidgetRef ref;

  TabNavigationObserver({
    required this.ref,
  });

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    // Perform tasks on first navigation
  }

  @override
  Future<void> didChangeTabRoute(
      TabPageRoute route,
      TabPageRoute previousRoute,
      ) async {
    if (route.name == 'DepartureRoute') {
      return ref.refresh(favoriteListProvider);
    }
    return;
  }
}