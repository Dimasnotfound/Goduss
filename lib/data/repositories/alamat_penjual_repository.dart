import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alamat_penjual_model.dart';
import '../database/database.dart';

class AlamatPenjualRepository {
  final DatabaseProvider _databaseProvider;

  AlamatPenjualRepository(this._databaseProvider);

  Future<void> createAlamatPenjualTable() async {
    final db = await _databaseProvider.database;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS alamat_penjual(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        FK_idUser INTEGER,
        dusun TEXT,
        rt TEXT,
        rw TEXT,
        jalan TEXT,
        desa TEXT,
        kecamatan TEXT,
        kabupaten TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  Future<void> insertAlamatPenjual(AlamatPenjual alamat) async {
    final db = await _databaseProvider.database;
    await db.insert('alamat_penjual', alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> getLatitudeLongitude(AlamatPenjual alamat) async {
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

  Future<AlamatPenjual?> getAlamatPenjual(int idUser) async {
    final db = await _databaseProvider.database;
    final maps = await db.query(
      'alamat_penjual',
      where: 'FK_idUser = ?',
      whereArgs: [idUser],
    );
    if (maps.isNotEmpty) {
      return AlamatPenjual.fromMap(maps.first);
    }
    return null;
  }

  Future<void> insertOrUpdateAlamatPenjual(AlamatPenjual alamat) async {
    final db = await _databaseProvider.database;

    // Cek apakah data alamat penjual sudah ada berdasarkan ID pengguna
    final existingAlamat = await getAlamatPenjual(alamat.fkIdUser ?? -1);

    if (existingAlamat != null) {
      // Jika sudah ada, lakukan pembaruan (update) tanpa menyertakan kolom id
      await db.update(
        'alamat_penjual',
        {
          'FK_idUser': alamat.fkIdUser,
          'dusun': alamat.dusun,
          'rt': alamat.rt,
          'rw': alamat.rw,
          'jalan': alamat.jalan,
          'desa': alamat.desa,
          'kecamatan': alamat.kecamatan,
          'kabupaten': alamat.kabupaten,
          'latitude': alamat.latitude,
          'longitude': alamat.longitude,
        },
        where: 'id = ?',
        whereArgs: [existingAlamat.id],
      );
    } else {
      // Jika belum ada, lakukan penambahan (insert)
      await db.insert(
        'alamat_penjual',
        alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
