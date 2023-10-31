class NewsLineFields {
  static final List<String> values = [name, typeOfTransport];
  static const String name = 'name';
  static const String typeOfTransport = 'typeOfTransport';
}

class NewsLine {
  final String name;
  final String typeOfTransport;

  const NewsLine({required this.name, required this.typeOfTransport});

  factory NewsLine.fromJson(Map<String, dynamic> json) {
    return NewsLine(
        name: json['name'], typeOfTransport: json['typeOfTransport']);
  }

  Map<String, Object?> toJson() => {
        NewsLineFields.name: name,
        NewsLineFields.typeOfTransport: typeOfTransport
      };
}
