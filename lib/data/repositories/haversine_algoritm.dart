// haversine_algorithm.dart
import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class HaversineAlgorithm {
  static Map<LatLng, double> calculateDistances(
      LatLng start, Map<LatLng, IconData> markerMap) {
    final Map<LatLng, double> distances = {};

    for (var entry in markerMap.entries) {
      final double distance = calculateDistance(start, entry.key);
      distances[entry.key] = distance;
    }

    return distances;
  }

  static double calculateDistance(LatLng start, LatLng end) {
    const int radiusOfEarth = 6371; // Radius of Earth in kilometers

    final double startLatInRadians = degreesToRadians(start.latitude);
    final double startLongInRadians = degreesToRadians(start.longitude);
    final double endLatInRadians = degreesToRadians(end.latitude);
    final double endLongInRadians = degreesToRadians(end.longitude);

    final double deltaLat = endLatInRadians - startLatInRadians;
    final double deltaLong = endLongInRadians - startLongInRadians;

    final double a = (calculateHaversine(deltaLat) +
        cos(startLatInRadians) *
            cos(endLatInRadians) *
            calculateHaversine(deltaLong));
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radiusOfEarth * c;
  }

  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  static double calculateHaversine(double theta) {
    return pow(sin(theta / 2), 2).toDouble();
  }
}
