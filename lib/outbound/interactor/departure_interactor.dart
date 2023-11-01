import 'package:http/http.dart' as http;
import 'package:track_your_stop/modules/departure/control/departure_control.dart';
import 'package:track_your_stop/outbound/control/departure_parser.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';
import 'package:track_your_stop/outbound/models/station_response.dart';
import 'package:track_your_stop/utils/list.util.dart';
import 'package:track_your_stop/utils/logger.dart';
import 'package:track_your_stop/utils/string.util.dart';

final logger = getLogger("DepartureInteractor");

class DepartureInteractor {
  static const baseUri = "https://www.mvg.de/api/fib/v2";

  static Future<List<DepartureResponse>> fetchDepartures(
      String globalStationId,
      final List<String> transportTypes,
      final String destination,
      final int departureCountSetting) async {
    final transformedTransportTypes = convertArrayToString(transportTypes);
    final response = await http.get(Uri.parse(
        '$baseUri/departure?globalId=$globalStationId&limit=50&offsetInMinutes=0&transportTypes=$transformedTransportTypes'));

    if (response.statusCode != 200) return List.empty();

    final departureData = parseDepartureResponse(response, destination);
    return filterDepartures(departureData, departureCountSetting);
  }

  static Future<List<DepartureResponse>>
      fetchDeparturesByOriginAndTransportTypes(
          final StationResponse? stationResponse,
          final List<String> transportTypes) async {
    final transformedTransportTypes = convertArrayToString(transportTypes);
    final response = await http.get(Uri.parse(
        '$baseUri/departure?globalId=${stationResponse!.globalId}&limit=50&offsetInMinutes=0&transportTypes=$transformedTransportTypes'));

    if (response.statusCode != 200) return List.empty();

    final departureData = parseDepartureResponseForOrigin(response);
    return departureData.unique((el) => el.destination);
  }
}
