import 'package:track_your_stop/outbound/models/news_line.dart';

class NewsFields {
  static final List<String> values = [type, title, lines];
  static const String type = 'type';
  static const String title = 'title';
  static const String lines = 'lines';
}

class NewsResponse {
  final String type;
  final String title;
  final List<NewsLine> lines;

  const NewsResponse({
    required this.type,
    required this.title,
    required this.lines,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
        type: json['type'],
        title: json['title'],
        lines: List<NewsLine>.from(
            json["lines"].map((x) => NewsLine.fromJson(x))));
  }

  Map<String, Object?> toJson() => {
        NewsFields.type: type,
        NewsFields.title: title,
        NewsFields.lines: List<dynamic>.from(lines.map((x) => x.toJson())),
      };
}
