import 'package:flutter/material.dart';
import 'package:mvv_tracker/constants/colors.dart';
import 'package:mvv_tracker/utils/arrival_accent.util.dart';

Card buildCard(IconData line, String destination, int arrivalTime) => Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          decoration: BoxDecoration(
              color: darkPrimaryColor, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.5, color: Colors.white24))),
                child: Icon(line, color: Colors.white),
              ),
              title: Text(
                destination,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale,
                      color: getAccentColorForTime(arrivalTime)),
                  Text(" $arrivalTime min",
                      style: const TextStyle(color: Colors.white))
                ],
              ),
              trailing: const Icon(Icons.more_vert,
                  color: Colors.white, size: 30.0))),
    );
