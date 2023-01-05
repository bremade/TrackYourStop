import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/utils/logger.dart';

class FavoriteAppBar extends ConsumerWidget with PreferredSizeWidget {
  FavoriteAppBar({
    Key? key,
  }) : super(key: key);

  final logger = getLogger("BottomAppBar");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Add favorite'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_location),
          tooltip: 'Add favorite station',
          onPressed: () => print('Test'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
