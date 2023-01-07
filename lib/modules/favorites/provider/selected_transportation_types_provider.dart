import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TransportationTypeEnum {
  ubahn("UBAHN"),
  tram("TRAM"),
  bus("BUS"),
  sbahn("SBAHN");

  final String name;

  const TransportationTypeEnum(this.name);
}

class SelectedTransportationTypesNotifier extends StateNotifier<List<String>> {
  SelectedTransportationTypesNotifier() : super([]);

  void addTransportationType(String type) {
    type = type.toUpperCase();
    if (!state.contains(type)) {
      state = [...state, type];
    }
  }

  void removeTransportationType(String typeToDelete) {
    typeToDelete = typeToDelete.toUpperCase();
    state = [
      for (final type in state)
        if (type != typeToDelete) type,
    ];
  }
}

final selectedTransportationTypesProvider =
    StateNotifierProvider<SelectedTransportationTypesNotifier, List<String>>((ref) {
  return SelectedTransportationTypesNotifier();
});
