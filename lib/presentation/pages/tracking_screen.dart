import 'package:flutter/material.dart';
import '../widget/tracking_widget.dart';

class TrackingScreen extends StatelessWidget {
  final int userId;
  final double? latitude;
  final double? longitude;

  const TrackingScreen({
    Key? key,
    required this.userId,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetTrackingScreen(
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }
}
