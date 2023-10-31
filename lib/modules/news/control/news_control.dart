import 'package:track_your_stop/modules/favorites/models/favorite.model.dart';
import 'package:track_your_stop/outbound/models/news_line.dart';
import 'package:track_your_stop/outbound/models/news_response.dart';

Future<List<NewsResponse>> filterNews(
    List<NewsResponse> newsData, Future<List<Favorite>> favorites) async {
  var filteredTransportationIds = await favorites;
  List<String> ids = filteredTransportationIds.map((e) => e.labels).toList();
  return newsData.where((news) {
    return _getLineIds(news.lines).any(_transportIdsToSet(ids).contains);
  }).toList();
}

Set<String> _getLineIds(List<NewsLine> lines) {
  return lines.map((e) => e.name).toSet();
}

Set<String> _transportIdsToSet(List<String> concatedTransportIds) {
  return concatedTransportIds.map((e) => e.split(",").toList()).expand((e) {
    return e;
  }).toSet();
}
