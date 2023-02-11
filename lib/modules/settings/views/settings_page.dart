import 'dart:collection';

import 'package:TrackYourStop/utils/transportation_type.util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/constants/colors.dart';
import 'package:TrackYourStop/constants/departure_card_choices.dart';
import 'package:TrackYourStop/modules/departure/control/departure_control.dart';
import 'package:TrackYourStop/modules/favorites/database/favorites_database.dart';
import 'package:TrackYourStop/modules/favorites/models/favorite.model.dart';
import 'package:TrackYourStop/modules/favorites/provider/favorite_list_provider.dart';
import 'package:TrackYourStop/modules/departure/ui/create_favorite_fab.dart';
import 'package:TrackYourStop/modules/departure/ui/departure_card.dart';
import 'package:TrackYourStop/outbound/models/departure_response.dart';
import 'package:TrackYourStop/shared/ui/bottom_app_bar.dart';
import 'package:TrackYourStop/utils/arrival_accent.util.dart';
import 'package:TrackYourStop/utils/logger.dart';

final logger = getLogger("SettingsPage");

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomAppNavigationBar(),
    );
  }
}
