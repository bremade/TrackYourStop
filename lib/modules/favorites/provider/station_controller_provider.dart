import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/modules/favorites/database/favorites_database.dart';

final stationControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});