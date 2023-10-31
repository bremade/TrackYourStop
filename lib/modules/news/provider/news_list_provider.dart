import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/outbound/interactor/mvg_news_interactor.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';

final newsListProvider = StateProvider<Future<List<NewsResponse>>>((ref) {
  return MvgNewsInteractor.fetchNews();
});
