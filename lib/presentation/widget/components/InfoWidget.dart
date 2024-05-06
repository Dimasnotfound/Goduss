import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.infoText,
    required this.topLeftText,
    required this.bottomLeftText,
    this.topLeftIcon,
    this.bottomLeftIcon,
    required this.iconAsset,
    required this.markerChild,
    required this.markerPosition,
    this.elevation = 6,
  }) : super(key: key);

  final String infoText;
  final String topLeftText;
  final String bottomLeftText;
  final Widget? topLeftIcon;
  final Widget? bottomLeftIcon;
  final String iconAsset;
  final Widget markerChild;
  final LatLng markerPosition;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      splashRadius: 0,
      surfaceTintColor: Colors.transparent,
      padding: EdgeInsets.zero,
      elevation: elevation,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          child: Card(
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF7DA0CA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green.shade900,
                      ),
                    ],
                  ),
                  Text(
                    infoText,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      topLeftIcon ??
                          SizedBox(), // Menampilkan ikon jika tersedia
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topLeftText,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            bottomLeftText,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      bottomLeftIcon ?? SizedBox(),
                      Spacer(),
                      Image.asset(
                        iconAsset,
                        width: 52,
                        height: 81,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      onSelected: (value) {},
      position: PopupMenuPosition.over,
      child: markerChild,
    );
  }
}
