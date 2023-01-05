class DepartureFields {
  static final List<String> values = [
    realtimeDepartureTime,
    delay,
    transportType,
    label,
    destination
  ];
  static const String realtimeDepartureTime = 'realtimeDepartureTime';
  static const String delay = 'delay';
  static const String transportType = 'transportType';
  static const String label = 'label';
  static const String destination = 'destination';
}

class DepartureResponse {
  final int realtimeDepartureTime;
  final int delay;
  final String transportType;
  final String label;
  final String destination;

  const DepartureResponse(
      {required this.realtimeDepartureTime,
      required this.delay,
      required this.transportType,
      required this.label,
      required this.destination});

  factory DepartureResponse.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    final departure =
        DateTime.fromMillisecondsSinceEpoch(json['realtimeDepartureTime']);
    return DepartureResponse(
      realtimeDepartureTime: now.difference(departure).inMinutes * -1,
      delay: json['delayInMinutes'] ?? 0,
      transportType: json['transportType'],
      label: json['label'],
      destination: json['destination'],
    );
  }

  Map<String, Object?> toJson() => {
        DepartureFields.realtimeDepartureTime: realtimeDepartureTime,
        DepartureFields.delay: delay,
        DepartureFields.transportType: transportType,
        DepartureFields.label: label,
        DepartureFields.destination: destination
      };
}
