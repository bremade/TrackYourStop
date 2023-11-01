import 'package:flutter/material.dart';

Color getAccentColorForTime(int arrivalTime) {
  if (arrivalTime <= 5) {
    return Colors.redAccent;
  } else if (arrivalTime <= 10) {
    return Colors.yellowAccent;
  } else {
    return Colors.lightGreenAccent;
  }
}
