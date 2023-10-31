import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/modules/favorites/database/favorites_database.dart';
import 'package:track_your_stop/modules/settings/provider/news_settings_provider.dart';
import 'package:track_your_stop/outbound/interactor/mvg_news_interactor.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';
import 'package:track_your_stop/utils/logger.dart';

final logger = getLogger("NewsListProvider");

final newsListProvider = StateProvider<Future<List<NewsResponse>>>((ref) {
  bool shouldFilter = ref.watch(newsSettingsFilterProvider);
  bool shouldFetchAll = ref.watch(newsSettingsFetchAllProvider);
  return MvgNewsInteractor.fetchNews(
      shouldFilter: shouldFilter,
      currentTransportationIds: FavoritesDatabase.instance.readAll(),
      all: shouldFetchAll);
});
