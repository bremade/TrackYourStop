class StationFields {
  static final List<String> values = [
    type,
    name,
    globalId,
    transportTypes,
    tariffZones
  ];
  static const String type = 'type';
  static const String name = 'name';
  static const String globalId = 'globalId';
  static const String transportTypes = 'transportTypes';
  static const String tariffZones = 'tariffZones';
}

class StationResponse {
  final String type;
  final String name;
  final String globalId;
  final List<String> transportTypes;
  final String tariffZones;

  const StationResponse(
      {required this.type,
      required this.name,
      required this.globalId,
      required this.transportTypes,
      required this.tariffZones});

  factory StationResponse.fromJson(Map<String, dynamic> json) {
    return StationResponse(
      type: json['type'],
      name: json['name'],
      globalId: json['globalId'],
      transportTypes: (json['transportTypes']).cast<String>(),
      tariffZones: json['tariffZones'],
    );
  }

  Map<String, Object?> toJson() => {
        StationFields.type: type,
        StationFields.name: name,
        StationFields.globalId: globalId,
        StationFields.transportTypes: transportTypes,
        StationFields.tariffZones: tariffZones
      };
}
