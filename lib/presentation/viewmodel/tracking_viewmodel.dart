import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../data/database/database.dart';
import '../../data/models/alamat_pembeli.dart';
import '../../data/models/rekap.dart';

import 'dart:convert';
import 'package:clean_godus/data/repositories/haversine_algoritm.dart';

class TrackingViewModel extends ChangeNotifier {
  final double? latitude;
  final double? longitude;
  final Map<LatLng, IconData> markerMap;
  List<LatLng> routpoints = [];
  late BuildContext context;
  DateTime? selectedDate;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Tambahkan atribut selectedDate

  TrackingViewModel({
    required this.context,
    this.latitude,
    this.longitude,
    required this.markerMap,
  }) : selectedDate = null;

  Future<void> getRoute() async {
    final LatLng start = LatLng(latitude ?? 0.0, longitude ?? 0.0);
    final Map<LatLng, double> distances =
        HaversineAlgorithm.calculateDistances(start, markerMap);

    // Sorting markerMap by distance in ascending order
    final sortedMarkerMap = Map.fromEntries(
      distances.entries.toList()..sort((a, b) => a.value.compareTo(b.value)),
    );

    var startLat = latitude;
    var startLong = longitude;

    for (var entry in sortedMarkerMap.entries) {
      var endLat = entry.key.latitude;
      var endLong = entry.key.longitude;

      var url = Uri.parse(
          'http://router.project-osrm.org/route/v1/driving/$startLong,$startLat;$endLong,$endLat?steps=true&annotations=true&geometries=geojson&overview=full');
      var response = await http.get(url);
      print(response.body);

      var ruter =
          jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
      for (int i = 0; i < ruter.length; i++) {
        var reep = ruter[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(",");
        routpoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }

      // Setelah menambahkan rute untuk satu titik, titik ini menjadi titik awal berikutnya
      startLat = endLat;
      startLong = endLong;
    }

    print(routpoints);
  }

  Future<void> selectDate() async {
    // Set isLoading menjadi true saat pemilihan tanggal dimulai
    notifyListeners();
    // Beritahu listener tentang perubahan isLoading

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _isLoading = true;
      notifyListeners();
      markerMap.clear();
      routpoints.clear(); // Beritahu listener tentang perubahan selectedDate

      // Ambil tanggal dengan format "dd-mm-yyyy"
      final formattedDay =
          picked.day < 10 ? '0${picked.day}' : picked.day.toString();
      final formattedMonth =
          picked.month < 10 ? '0${picked.month}' : picked.month.toString();
      final formattedDate = "$formattedDay-$formattedMonth-${picked.year}";

      print(formattedDate);

      // Lakukan pencarian dalam database
      final List<int> ids =
          await DatabaseProvider.instance.findIdsByDate(formattedDate);
      print('FK_id_alamat_pembeli: $ids');

      if (ids.isNotEmpty) {
        for (int id in ids) {
          // Lakukan query untuk mendapatkan data alamat pembeli berdasarkan id
          final AlamatPembeli? alamatPembeli =
              await DatabaseProvider.instance.getAlamatPembeliById(id);
          if (alamatPembeli != null) {
            final Rekap? rekap = await DatabaseProvider.instance
                .getRekapById(alamatPembeli.id ?? 0);
            print(rekap);

           

            double latitude = alamatPembeli.latitude ?? 0.0;
            double longitude = alamatPembeli.longitude ?? 0.0;

            // Refresh UI dengan mengatur isLoading menjadi false
            _isLoading = false;
            notifyListeners(); // Beritahu listener tentang perubahan isLoading

            // Tambahkan marker ke markerMap setelah isLoading selesai
            markerMap[LatLng(latitude, longitude)] = Icons.location_pin;

            // Lakukan operasi yang diperlukan dengan latitude dan longitude
            // Misalnya, tampilkan atau simpan data ke suatu tempat
            print('Latitude: $latitude, Longitude: $longitude');
          }
        }
        getRoute();
      } else {
        // Refresh UI dengan mengatur isLoading menjadi false jika tidak ada data
        _isLoading = false;
        notifyListeners(); // Beritahu listener tentang perubahan isLoading
      }
    }
  }
}
