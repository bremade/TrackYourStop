import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsSettingsFilterProvider = StateProvider<bool>((ref) {
  return false;
});

final newsSettingsFetchAllProvider = StateProvider<bool>((ref) {
  return false;
});
