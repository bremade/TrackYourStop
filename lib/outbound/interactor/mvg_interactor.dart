import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvv_tracker/outbound/models/departure_response.dart';
import 'package:mvv_tracker/outbound/models/station_response.dart';
import 'package:mvv_tracker/utils/list.util.dart';
import 'package:mvv_tracker/utils/string.util.dart';

class MvgInteractor {
  static const baseUri = "https://www.mvg.de/api/fib/v2";

  Future<http.Response> fetchStops(String location) {
    return http.get(Uri.parse('$baseUri/location?query=$location'));
  }

  static Future<List<DepartureResponse>> fetchDepartures(
      String globalStationId,
      final List<String> transportTypes,
      final List<String> destinations) async {
    final transformedTransportTypes = convertArrayToString(transportTypes);
    final response = await http.get(Uri.parse(
        '$baseUri/departure?globalId=$globalStationId&limit=50&offsetInMinutes=0&transportTypes=$transformedTransportTypes'));
    if (response.statusCode == 200) {
      final departureData = (json.decode(response.body) as List)
          .where((departureData) =>
              destinations.contains(departureData['destination']))
          .map((departureData) => DepartureResponse.fromJson(departureData))
          .toList();
      return departureData.unique((el) => el.destination);
    } else {
      return List.empty();
    }
  }

  static Future<List<StationResponse>> fetchStationData(
      String stationName) async {
    final response =
        await http.get(Uri.parse('$baseUri/location?query=$stationName'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .where((stationData) => stationData['type'] == 'STATION')
          .map((stationData) => StationResponse.fromJson(stationData))
          .toList();
    } else {
      return List.empty();
    }
  }
}
