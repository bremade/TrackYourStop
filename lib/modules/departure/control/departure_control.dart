import 'dart:collection';

import 'package:track_your_stop/modules/favorites/models/favorite.model.dart';
import 'package:track_your_stop/outbound/interactor/departure_interactor.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';
import 'package:track_your_stop/utils/logger.dart';
import 'package:track_your_stop/utils/string.util.dart';

final logger = getLogger("DepartureControl");

void addDepartureDataToMap(HashMap<String, List<DepartureResponse>> stationMap,
    Favorite favorite, List<DepartureResponse> departureData) {
  if (departureData.isNotEmpty) {
    if (stationMap.containsKey(favorite.origin) &&
        stationMap[favorite.origin] != null) {
      stationMap[favorite.origin]?.addAll(departureData);
    } else {
      stationMap[favorite.origin] = departureData;
    }
  }
}

Future<HashMap<String, List<DepartureResponse>>> buildStationMap(
    Future<List<Favorite>> favorites, int departureCountSetting) async {
  final HashMap<String, List<DepartureResponse>> stationMap = HashMap();
  var favoriteData = await favorites;
  for (Favorite favorite in favoriteData) {
    List<DepartureResponse> departureData =
        await DepartureInteractor.fetchDepartures(
            favorite.originGlobalId,
            convertStringToArray(favorite.types),
            favorite.destination,
            departureCountSetting);
    addDepartureDataToMap(stationMap, favorite, departureData);
  }
  return stationMap;
}

List<DepartureResponse> filterDepartureData(
    Map<String, List<DepartureResponse>> destinationMap,
    int departureCountSetting) {
  final List<DepartureResponse> filteredDepartures = [];
  for (final destination in destinationMap.keys) {
    final List<DepartureResponse> departures = destinationMap[destination]!;
    if (departures.length < departureCountSetting) {
      filteredDepartures.addAll(departures);
    } else {
      filteredDepartures.addAll(departures.sublist(0, departureCountSetting));
    }
  }
  return filteredDepartures;
}

List<DepartureResponse> filterDepartures(
    departureData, int departureCountSetting) {
  final Map<String, List<DepartureResponse>> destinationMap = {};
  for (final departure in departureData) {
    if (!destinationMap.containsKey(departure.destination)) {
      destinationMap[departure.destination] = [];
    }
    destinationMap[departure.destination]!.add(departure);
  }

  return filterDepartureData(destinationMap, departureCountSetting);
}
