import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/routing/router.dart';

class CreateFavoriteFab extends ConsumerWidget {
  const CreateFavoriteFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    return FloatingActionButton(
      onPressed: () => router.push(const FavoriteRoute()),
      child: const Icon(Icons.add),
    );
  }
}
