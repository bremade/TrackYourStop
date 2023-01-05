import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TransportationTypeEnum {
  ubahn("UBAHN"),
  tram("TRAM"),
  bus("BUS"),
  sbahn("SBAHN");

  final String name;

  const TransportationTypeEnum(this.name);
}

class TransportationTypeNotifier extends StateNotifier<List<String>> {
  TransportationTypeNotifier() : super([]);

  void addTransportationType(String type) {
    if (!state.contains(type)) {
      state = [...state, type];
    }
  }

  void removeTransportationType(String typeToDelete) {
    state = [
      for (final type in state)
        if (type != typeToDelete) type,
    ];
  }
}

final transportationTypeProvider =
    StateNotifierProvider<TransportationTypeNotifier, List<String>>((ref) {
  return TransportationTypeNotifier();
});
