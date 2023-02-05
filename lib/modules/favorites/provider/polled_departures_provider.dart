import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/outbound/models/departure_response.dart';

final polledDeparturesProvider = StateProvider<Future<List<DepartureResponse>>>((ref) {
  return Future.value([]);
});