import 'package:flutter/material.dart';
import 'package:track_your_stop/outbound/models/news_line.dart';

class NewsCardData {
  final BuildContext context;
  final bool urgent;
  final String title;
  final List<NewsLine> lines;
  final Color containerColor;
  final Color textColor;
  final List<ImageProvider> transportationTypeAssets;

  NewsCardData({
    required this.context,
    required this.urgent,
    required this.title,
    required this.lines,
    required this.containerColor,
    required this.textColor,
    required this.transportationTypeAssets,
  });
}
