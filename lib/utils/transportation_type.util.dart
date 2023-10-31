import 'package:track_your_stop/utils/logger.dart';
import 'package:flutter/material.dart';

var charOnlyPostfix = "CHAR";
var defaultAsset = "assets/images/ubahn.png";
var typeToAssetMap = {
  "UBAHN": "assets/images/ubahn.png",
  "UBAHNCHAR": "assets/images/ubahn.png",
  "METRO": "assets/images/ubahn.png",
  "METROCHAR": "assets/images/ubahn.png",
  "BUS": "assets/images/bus.png",
  "BUSCHAR": "assets/images/busChar.png",
  "TRAM": "assets/images/tram.png",
  "TRAMCHAR": "assets/images/tramChar.png",
  "SBAHN": "assets/images/sbahn.png",
  "SBAHNCHAR": "assets/images/sbahn.png",
  "BAHN": "assets/images/bahn.png",
  "BAHNCHAR": "assets/images/bahn.png"
};

var logger = getLogger("TransportationTypeUtils");

String getAssetForTransportationType(String type) {
  return typeToAssetMap[type] ?? defaultAsset;
}

List<ImageProvider> getAssetListForTransportationType(Iterable<String> types,
    {bool charOnly = false}) {
  final List<ImageProvider> assetList = <ImageProvider>[];
  for (var type in types) {
    assetList.add(ExactAssetImage(
        typeToAssetMap[charOnly ? "$type$charOnlyPostfix" : type] ??
            defaultAsset));
  }
  return assetList;
}
