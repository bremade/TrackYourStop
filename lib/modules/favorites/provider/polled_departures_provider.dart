import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/outbound/models/departure_response.dart';

final polledDeparturesProvider =
    StateProvider<Future<List<DepartureResponse>>>((ref) => Future.value([]));
