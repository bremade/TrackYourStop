import 'dart:convert';

import 'package:track_your_stop/outbound/models/departure_response.dart';

List<DepartureResponse> parseDepartureResponse(jsonData, destination) {
  return (json.decode(jsonData.body) as List)
      .where((departureData) => destination == departureData['destination'])
      .map((departureData) => DepartureResponse.fromJson(departureData))
      .where((departureDataObject) =>
          departureDataObject.realtimeDepartureTime <= 120)
      .toList();
}

List<DepartureResponse> parseDepartureResponseForOrigin(jsonData) {
  return (json.decode(jsonData.body) as List)
      .map((departureData) => DepartureResponse.fromJson(departureData))
      .toList();
}
