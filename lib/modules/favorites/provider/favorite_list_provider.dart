import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvv_tracker/modules/favorites/database/favorites_database.dart';
import 'package:mvv_tracker/modules/favorites/models/favorite.model.dart';

final favoriteListProvider = StateProvider<Future<List<Favorite>>>((ref) {
  return FavoritesDatabase.instance.readAll();
});