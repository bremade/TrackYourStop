import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:TrackYourStop/outbound/models/departure_response.dart';

class SelectedDestinationsNotifier extends StateNotifier<List<DepartureResponse>> {
  SelectedDestinationsNotifier() : super([]);

  void addDestination(DepartureResponse departure) {
    if (!state.contains(departure)) {
      state = [...state, departure];
    }
  }

  void removeDestination(DepartureResponse departureToDelete) {
    state = [
      for (final departure in state)
        if (departure.destination != departureToDelete.destination) departure,
    ];
  }
}

final selectedDestinationsProvider =
StateNotifierProvider<SelectedDestinationsNotifier, List<DepartureResponse>>((ref) {
  return SelectedDestinationsNotifier();
});
