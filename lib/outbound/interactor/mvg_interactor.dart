import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_your_stop/outbound/models/departure_response.dart';
import 'package:track_your_stop/outbound/models/station_response.dart';
import 'package:track_your_stop/utils/list.util.dart';
import 'package:track_your_stop/utils/logger.dart';
import 'package:track_your_stop/utils/string.util.dart';

final logger = getLogger("MvgInteractor");

class MvgInteractor {
  static const baseUri = "https://www.mvg.de/api/fib/v2";

  static Future<List<DepartureResponse>> fetchDepartures(
      String globalStationId,
      final List<String> transportTypes,
      final String destination) async {
    final transformedTransportTypes = convertArrayToString(transportTypes);
    final response = await http.get(Uri.parse(
        '$baseUri/departure?globalId=$globalStationId&limit=50&offsetInMinutes=0&transportTypes=$transformedTransportTypes'));
    if (response.statusCode == 200) {
      final departureData = (json.decode(response.body) as List)
          .where((departureData) =>
              destination == departureData['destination'])
          .map((departureData) => DepartureResponse.fromJson(departureData))
          .where((departureDataObject) => departureDataObject.realtimeDepartureTime <= 120)
          .toList();
      return departureData.unique((el) => el.destination);
    } else {
      return List.empty();
    }
  }

  static Future<List<DepartureResponse>> fetchDeparturesByOriginAndTransportTypes(final StationResponse? stationResponse, final List<String> transportTypes) async {
    final transformedTransportTypes = convertArrayToString(transportTypes);
    final response = await http.get(Uri.parse(
        '$baseUri/departure?globalId=${stationResponse!.globalId}&limit=50&offsetInMinutes=0&transportTypes=$transformedTransportTypes'));
    if (response.statusCode == 200) {
      final departureData = (json.decode(response.body) as List)
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

  static Future<List<StationResponse>> getStationSuggestions(String stationName) async {
    logger.d('Execution api call for station suggestions.');
    final response =
    await http.get(Uri.parse('$baseUri/location?query=$stationName'));
    if (stationName == '') {
      return List<StationResponse>.empty();
    }
    if (response.statusCode == 200) {

      final stationList = (json.decode(response.body) as List)
          .where((stationData) => stationData['type'] == 'STATION')
          .map((stationData) => StationResponse.fromJson(stationData))
          .toList();

      for (var element in stationList) {logger.d(element.toJson());}

      return stationList.where((StationResponse option) {
        return option.name.toLowerCase()
            .contains(stationName.toLowerCase());
      }).toList();
    } else {
      return List<StationResponse>.empty();
    }
  }
}
