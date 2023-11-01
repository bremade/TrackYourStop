import 'dart:convert';

import 'package:track_your_stop/outbound/models/news_response.dart';

List<NewsResponse> parseNewsResponse(jsonData, all) {
  return (json.decode(jsonData.body) as List)
      .map((newsData) => NewsResponse.fromJson(newsData))
      .where(
          (newsDataObject) => all ? true : newsDataObject.type == 'DISRUPTION')
      .toList();
}
