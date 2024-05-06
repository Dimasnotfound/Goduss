import 'package:flutter/material.dart';
import '../../data/models/alamat_penjual_model.dart';
import '../../data/repositories/alamat_penjual_repository.dart';
import '../../data/database/database.dart';
import 'landing_page_screen.dart';
import '../widget/input_alamat_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InitAlamatScreen extends StatefulWidget {
  final int idUser;

  const InitAlamatScreen({Key? key, required this.idUser}) : super(key: key);

  @override
  _InitAlamatScreenState createState() => _InitAlamatScreenState();
}

class _InitAlamatScreenState extends State<InitAlamatScreen> {
  final AlamatPenjualRepository _alamatPenjualRepository =
      AlamatPenjualRepository(DatabaseProvider.instance);

  final TextEditingController _dusunController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _jalanController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kabupatenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Mendapatkan data alamat penjual dari database saat widget diinisialisasi
    _getAlamatPenjualData();
  }

  Future<void> _getAlamatPenjualData() async {
    final alamatPenjual =
        await _alamatPenjualRepository.getAlamatPenjual(widget.idUser);
    if (alamatPenjual != null) {
      // Jika data alamat penjual ada, isi nilai controller dengan nilai yang ada
      _dusunController.text = alamatPenjual.dusun ?? '';
      _rtController.text = alamatPenjual.rt ?? '';
      _rwController.text = alamatPenjual.rw ?? '';
      _jalanController.text = alamatPenjual.jalan ?? '';
      _desaController.text = alamatPenjual.desa ?? '';
      _kecamatanController.text = alamatPenjual.kecamatan ?? '';
      _kabupatenController.text = alamatPenjual.kabupaten ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/eclipse_alamat_penjual.png', // Ubah dengan path gambar Anda
              // Sesuaikan tinggi gambar sesuai kebutuhan
              fit: BoxFit.cover, // Sesuaikan dengan kebutuhan
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/splash_screen_img.png', // Ubah dengan path gambar Anda
                width: 200, // Sesuaikan dengan kebutuhan
                height: 200, // Sesuaikan dengan kebutuhan
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/MASUKKAN_ALAMAT.png', // Ubah dengan path gambar Anda
                width: 300, // Sesuaikan dengan kebutuhan
                height: 300, // Sesuaikan dengan kebutuhan
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputAlamat(
                  dusunController: _dusunController,
                  rtController: _rtController,
                  rwController: _rwController,
                  jalanController: _jalanController,
                  desaController: _desaController,
                  kecamatanController: _kecamatanController,
                  kabupatenController: _kabupatenController,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // Membuat objek AlamatPenjual dengan nilai dari input controllers
                    final alamat = AlamatPenjual(
                      fkIdUser: widget.idUser,
                      dusun: _dusunController.text,
                      rt: _rtController.text,
                      rw: _rwController.text,
                      jalan: _jalanController.text,
                      desa: _desaController.text,
                      kecamatan: _kecamatanController.text,
                      kabupaten: _kabupatenController.text,
                    );

                    await _alamatPenjualRepository.getLatitudeLongitude(alamat);

                    // Memperbarui entri di database
                    await _alamatPenjualRepository
                        .insertOrUpdateAlamatPenjual(alamat);

                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.success(
                        message: "Data Berhasil Disimpan",
                      ),
                    );
                    // Navigasi ke halaman LandingPageScreen dengan membawa parameter userId
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingPageScreen(
                          userId: widget.idUser,
                          latitude: alamat.latitude,
                          longitude: alamat.longitude,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'SIMPAN',
                    style: TextStyle(
                      color: Color(
                          0xFF215CA8), // Warna teks biru sesuai kode yang diberikan
                      fontFamily: 'Poppins', // Menggunakan font Poppins
                      fontWeight: FontWeight.w600, // Berat font menjadi bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
