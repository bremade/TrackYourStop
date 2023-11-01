import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/database/favorites_database.dart';
import 'package:track_your_stop/modules/favorites/models/favorite.model.dart';

final favoriteListProvider = StateProvider<Future<List<Favorite>>>(
    (ref) => FavoritesDatabase.instance.readAll());
