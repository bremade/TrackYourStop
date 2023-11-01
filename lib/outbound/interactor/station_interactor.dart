import 'package:http/http.dart' as http;
import 'package:track_your_stop/outbound/control/station_parser.dart';
import 'package:track_your_stop/outbound/models/station_response.dart';
import 'package:track_your_stop/utils/logger.dart';

final logger = getLogger("StationInteractor");

class StatusInteractor {
  static const baseUri = "https://www.mvg.de/api/fib/v2";

  static Future<List<StationResponse>> fetchStationData(
      String stationName) async {
    logger.d('Execution api call for station data.');
    final response =
        await http.get(Uri.parse('$baseUri/location?query=$stationName'));
    if (response.statusCode != 200) return List.empty();
    return parseStationResponseData(response);
  }

  static Future<List<StationResponse>> getStationSuggestions(
      String stationName) async {
    if (stationName == '') return List.empty();
    logger.d('Executing api call for station suggestions.');
    final response =
        await http.get(Uri.parse('$baseUri/location?query=$stationName'));
    if (response.statusCode != 200) return List.empty();
    final stationList = parseStationResponseSuggestions(response);
    for (var element in stationList) {
      logger.d(element.toJson());
    }
    return stationList.where((StationResponse option) {
      return option.name.toLowerCase().contains(stationName.toLowerCase());
    }).toList();
  }
}
