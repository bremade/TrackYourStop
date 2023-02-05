import 'package:TrackYourStop/utils/logger.dart';
import 'package:flutter/material.dart';

var defaultAsset = "assets/images/ubahn.png";
var typeToAssetMap = {
  "UBAHN": "assets/images/ubahn.png",
  "BUS": "assets/images/bus.png",
  "TRAM": "assets/images/tram.png",
  "SBAHN": "assets/images/sbahn.png",
  "BAHN": "assets/images/bahn.png"
};

var logger = getLogger("TransportationTypeUtils");

String getAssetForTransportationType(String type) {
  logger.d("Converting type $type");
  return typeToAssetMap[type] ?? defaultAsset;
}

List<ImageProvider> getAssetListForTransportationType(List<String> types) {
  logger.d("Converting types $types");
  final List<ImageProvider> assetList = <ImageProvider>[];
  for (var type in types) {
    assetList.add(ExactAssetImage(typeToAssetMap[type] ?? defaultAsset));
  }
  return assetList;
}
