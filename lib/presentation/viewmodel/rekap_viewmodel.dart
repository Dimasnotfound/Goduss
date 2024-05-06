import 'dart:convert';
import 'package:clean_godus/data/models/rekap.dart';
import 'package:clean_godus/data/models/tracking.dart';
import 'package:http/http.dart' as http;
import '../../data/models/alamat_pembeli.dart';
import '../../data/database/database.dart';

class RekapViewModel {
  Future<void> getLatitudeLongitude(AlamatPembeli alamat) async {
    String apiKey = 'jA61AG11ixOJ2LPcjy4dmwCOfYjCZW4H';
    String url =
        'https://www.mapquestapi.com/geocoding/v1/address?key=$apiKey&street=${alamat.jalan}&city=${alamat.kabupaten}&state=Jawa Timur&Country=Indonesia&Neighborhood=${alamat.desa}&County=${alamat.kecamatan}';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          final locations = results[0]['locations'] as List<dynamic>;
          if (locations.isNotEmpty) {
            final latLng = locations[0]['latLng'];
            alamat.latitude = latLng['lat'];
            alamat.longitude = latLng['lng'];
          }
        }
        print(data);
      }
    } catch (e) {
      print('Error getting latitude and longitude: $e');
    }
  }

  Future<int> insertAlamat(AlamatPembeli alamat) async {
    int alamatId =
        await DatabaseProvider.instance.insertAlamatPembeli(alamat.toMap());
    return alamatId;
  }

  Future<int> insertRekap(Rekap rekap) async {
    int rekapId = await DatabaseProvider.instance.insertRekap(rekap.toMap());
    return rekapId;
  }

  Future<int> insertTracking(Tracking tracking) async {
    int alamatId =
        await DatabaseProvider.instance.insertTracking(tracking.toMap());
    return alamatId;
  }
}
