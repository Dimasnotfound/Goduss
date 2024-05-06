import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

class AlamatPenjualViewModel {
  String? dusun;
  String? rt;
  String? rw;
  String? jalan;
  String? desa;
  String? kecamatan;
  String? kabupaten;
  double? latitude;
  double? longitude;

  Future<void> mintaIzin() async {
    PermissionStatus statusLokasi =
        await Permission.locationWhenInUse.request();
    if (statusLokasi.isDenied) {
      throw Exception('Izin akses lokasi ditolak');
    }
  }

  Future<Map<String, dynamic>> cariLokasi() async {
    await mintaIzin();

    String apiKey = 'jA61AG11ixOJ2LPcjy4dmwCOfYjCZW4H';
    String location =
        'Dusun $dusun,$jalan,RT $rt,RW $rw,Desa $desa,Kecamatan $kecamatan,$kabupaten,Jawa Timur,Indonesia';
    String url =
        'https://www.mapquestapi.com/geocoding/v1/address?key=$apiKey&locations=$location';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> results = data['results'];
        if (results.isNotEmpty) {
          Map<String, dynamic> firstResult = results[0];
          List<dynamic> locations = firstResult['locations'];
          if (locations.isNotEmpty) {
            Map<String, dynamic> firstLocation = locations[0];
            Map<String, dynamic> latLng = firstLocation['latLng'];
            double latitude = latLng['lat'];
            double longitude = latLng['lng'];
            this.latitude = latitude;
            this.longitude = longitude;
            return {'latitude': latitude, 'longitude': longitude};
          }
        }
        return data;
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Gagal terhubung dengan server');
    }
  }
}
