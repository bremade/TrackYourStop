import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_your_stop/outbound/models/news_response.dart';
import 'package:track_your_stop/utils/logger.dart';

final logger = getLogger("MvgInteractor");

class MvgNewsInteractor {
  static const baseUri = "https://www.mvg.de/api";

  static Future<List<NewsResponse>> fetchNews({all = false}) async {
    final response = await http.get(Uri.parse('$baseUri/ems/tickers'));
    if (response.statusCode == 200) {
      final newsData = (json.decode(response.body) as List)
          .map((newsData) => NewsResponse.fromJson(newsData))
          .where((newsDataObject) =>
              all ? true : newsDataObject.type == 'DISRUPTION')
          .toList();

      return newsData;
    } else {
      return List.empty();
    }
  }
}
