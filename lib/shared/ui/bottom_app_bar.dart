import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/utils/logger.dart';
import 'package:TrackYourStop/shared/provider/app_bar_selection_provider.dart';

class BottomAppNavigationBar extends ConsumerWidget {
  BottomAppNavigationBar({
    Key? key,
  }) : super(key: key);

  final logger = getLogger("BottomAppBar");

  void _onIndexChange(int index, WidgetRef ref) {
    ref.read(appBarSelectionProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(appBarSelectionProvider);
    logger.d("Selected Index: $selectedIndex");
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.train),
          label: 'Departures',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) => _onIndexChange(index, ref),
    );
  }
}
