import '../../data/models/alamat_penjual_model.dart';
import '../../data/database/database.dart';

class AkunViewModel {
  final int userId;

  AkunViewModel({required this.userId});

  Future<Map<String, dynamic>> getAkunData() async {
    // Membuat objek DatabaseProvider
    final dbProvider = DatabaseProvider.instance;

    // Mendapatkan akses ke database
    final db = await dbProvider.database;

    // Mencari isi akun berdasarkan user ID
    final List<Map<String, dynamic>> akunResults = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (akunResults.isNotEmpty) {
      final Map<String, dynamic> akunData = akunResults.first;

      // Mendapatkan alamat berdasarkan ID akun
      final AlamatPenjual? alamat =
          await dbProvider.getAlamatPenjualById(akunData['id'] as int);

      // Mengembalikan data akun dan alamat
      print(alamat);
      print(akunData);
      return {
        'user': akunData,
        'alamat_penjual': alamat,
      };
    }

    // Jika tidak ditemukan akun dengan user ID yang diberikan
    return {};
  }
}
