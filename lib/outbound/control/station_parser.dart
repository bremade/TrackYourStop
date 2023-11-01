import 'dart:convert';

import 'package:track_your_stop/outbound/models/station_response.dart';

List<StationResponse> parseStationResponseData(jsonData) {
  return (json.decode(jsonData.body) as List)
      .where((stationData) => stationData['type'] == 'STATION')
      .map((stationData) => StationResponse.fromJson(stationData))
      .toList();
}

List<StationResponse> parseStationResponseSuggestions(jsonData) {
  return (json.decode(jsonData.body) as List)
      .where((stationData) => stationData['type'] == 'STATION')
      .map((stationData) => StationResponse.fromJson(stationData))
      .toList();
}
