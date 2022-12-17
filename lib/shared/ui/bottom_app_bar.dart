import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/utils/logger.dart';
import 'package:mvv_tracker/shared/provider/app_bar_selection_provider.dart';

class BottomAppNavigationBar extends ConsumerWidget {

  BottomAppNavigationBar({
    Key? key,
  }) : super(key: key);

  final logger = getLogger("BottomAppBar");

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Departures',
      style: optionStyle,
    ),
    Text(
      'Index 1: News',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onIndexChange(int index, WidgetRef ref) {
    ref.read(appBarSelectionProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(appBarSelectionProvider);
    logger.d("Selected Index: $selectedIndex");
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}