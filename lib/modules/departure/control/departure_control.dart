import 'dart:collection';

import 'package:mvv_tracker/modules/favorites/models/favorite.model.dart';
import 'package:mvv_tracker/outbound/interactor/mvg_interactor.dart';
import 'package:mvv_tracker/outbound/models/departure_response.dart';
import 'package:mvv_tracker/utils/logger.dart';
import 'package:mvv_tracker/utils/string.util.dart';

final logger = getLogger("DepartureControl");

Future<HashMap<String, List<DepartureResponse>>> buildStationMap(
    Future<List<Favorite>> favorites) async {
  final HashMap<String, List<DepartureResponse>> stationMap = HashMap();
  var favoriteData = await favorites;
  for (Favorite favorite in favoriteData) {
    List<DepartureResponse> departureData = await MvgInteractor.fetchDepartures(
        favorite.originGlobalId,
        convertStringToArray(favorite.types),
        favorite.destination);
    if (departureData.isNotEmpty) {
      if (stationMap.containsKey(favorite.origin) && stationMap[favorite.origin] != null) {
        stationMap[favorite.origin]?.addAll(departureData);
      } else {
        stationMap[favorite.origin] = departureData;
      }
    }
  }
  return stationMap;
}
