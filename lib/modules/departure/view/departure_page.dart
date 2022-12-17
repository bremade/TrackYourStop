import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/shared/ui/bottom_app_bar.dart';

class DeparturePage extends HookConsumerWidget {
  const DeparturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildBody() {
      return BottomAppNavigationBar();
    }

    return Scaffold(bottomNavigationBar: BottomAppNavigationBar());
  }
}
