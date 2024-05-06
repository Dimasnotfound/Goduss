import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/alamat_pembeli.dart';
import '../models/alamat_penjual_model.dart';
import '../models/rekap.dart';

class DatabaseProvider {
  static const _databaseName = 'godus.db';
  static const _databaseVersion = 1;

  DatabaseProvider._();
  static final DatabaseProvider instance = DatabaseProvider._();

  late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await _createTables(db);
    });
  }

  Future<void> _createTables(Database db) async {
    // Create AlamatPenjual table
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

    // Create Alamat Pembeli table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS alamat_pembeli(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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

    // Create Status Pengantaran table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS status_pengantaran(
            id_status_pengantaran INTEGER PRIMARY KEY AUTOINCREMENT,
            status TEXT
          )
          ''');

    // Insert data ke dalam tabel status_pengantaran
    await _insertInitialStatusPengantaran(db);

    // Create Rekap table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS rekap(
            id_rekap INTEGER PRIMARY KEY AUTOINCREMENT,
            FK_id_alamat_pembeli INTEGER,
            FK_status_pengantaran INTEGER,
            nama_pembeli TEXT,
            tanggal_pengantaran TEXT,
            jumlah_kambing INTEGER,
            harga REAL
          )
          ''');

    // Create Tracking table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS tracking(
            id_tracking INTEGER PRIMARY KEY AUTOINCREMENT,
            FK_idUser INTEGER,
            FK_idalamat_penjual INTEGER,
            FK_idalamat_pembeli INTEGER,
            FK_idRekap INTEGER
          )
          ''');
  }

  Future<void> _insertInitialStatusPengantaran(Database db) async {
    // Insert data status_pengantaran ke dalam tabel
    await db.insert('status_pengantaran', {'status': 'on_going'});
    await db.insert('status_pengantaran', {'status': 'done'});
  }

  Future<int> insertAlamatPembeli(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('alamat_pembeli', data);
  }

  Future<int> insertRekap(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('rekap', data);
  }

  Future<int> insertTracking(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('tracking', data);
  }

  Future<List<int>> findIdsByDate(String dateTime) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'rekap',
      columns: ['FK_id_alamat_pembeli'],
      where: 'tanggal_pengantaran = ?',
      whereArgs: [dateTime],
    );

    List<int> ids = [];
    for (var result in results) {
      ids.add(result['FK_id_alamat_pembeli'] as int);
    }

    return ids;
  }

  Future<AlamatPembeli?> getAlamatPembeliById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'alamat_pembeli',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      final Map<String, dynamic> data = results.first;
      return AlamatPembeli(
        id: data['id'] as int,
        dusun: data['dusun'] as String,
        rt: data['rt'] as String,
        rw: data['rw'] as String,
        jalan: data['jalan'] as String,
        desa: data['desa'] as String,
        kecamatan: data['kecamatan'] as String,
        kabupaten: data['kabupaten'] as String,
        latitude: data['latitude'] as double,
        longitude: data['longitude'] as double,
      );
    }
    return null;
  }

  Future<Rekap?> getRekapById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'rekap',
      where: 'FK_id_alamat_pembeli = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      final Map<String, dynamic> data = results.first;
      return Rekap(
        id: data['id_rekap'] as int,
        idAlamatPembeli: data['FK_id_alamat_pembeli'] as int,
        idStatusPengantaran: data['FK_status_pengantaran'] as int,
        namaPembeli: data['nama_pembeli'] as String,
        jumlahKambing: data['jumlah_kambing'] as int,
        harga: data['harga'] as double,
      );
    }
    return null;
  }

  Future<AlamatPenjual?> getAlamatPenjualById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'alamat_penjual',
      where: 'FK_idUser = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      final Map<String, dynamic> data = results.first;
      return AlamatPenjual(
        id: data['id'] as int,
        fkIdUser: data['FK_idUser'] as int,
        dusun: data['dusun'] as String,
        rt: data['rt'] as String,
        rw: data['rw'] as String,
        jalan: data['jalan'] as String,
        desa: data['desa'] as String,
        kecamatan: data['kecamatan'] as String,
        kabupaten: data['kabupaten'] as String,
        latitude: data['latitude'] as double,
        longitude: data['longitude'] as double,
      );
    }
    return null;
  }
}
