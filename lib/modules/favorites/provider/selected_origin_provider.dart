import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:track_your_stop/outbound/models/station_response.dart';

final selectedOriginProvider = StateProvider<StationResponse?>((ref) => null);
