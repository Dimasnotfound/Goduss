import 'package:flutter/material.dart';
import '../../data/models/alamat_penjual_model.dart';
import '../../data/repositories/alamat_penjual_repository.dart';
import '../../data/database/database.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InputAlamat extends StatefulWidget {
  final int userId;
  final TextEditingController dusunController;
  final TextEditingController rtController;
  final TextEditingController rwController;
  final TextEditingController jalanController;
  final TextEditingController desaController;
  final TextEditingController kecamatanController;
  final TextEditingController kabupatenController;
  final String? initialDusun;
  final String? initialRT;
  final String? initialRW;
  final String? initialJalan;
  final String? initialDesa;
  final String? initialKecamatan;
  final String? initialKabupaten;
  final VoidCallback onSaveCallback;

  const InputAlamat({
    Key? key,
    required this.userId,
    required this.dusunController,
    required this.rtController,
    required this.rwController,
    required this.jalanController,
    required this.desaController,
    required this.kecamatanController,
    required this.kabupatenController,
    this.initialDusun,
    this.initialRT,
    this.initialRW,
    this.initialJalan,
    this.initialDesa,
    this.initialKecamatan,
    this.initialKabupaten,
    required this.onSaveCallback,
  }) : super(key: key);

  @override
  _InputAlamatState createState() => _InputAlamatState();
}

class _InputAlamatState extends State<InputAlamat> {
  late final AlamatPenjualRepository _alamatPenjualRepository;

  @override
  void initState() {
    super.initState();
    _alamatPenjualRepository =
        AlamatPenjualRepository(DatabaseProvider.instance);
    if (widget.initialDusun != null) {
      widget.dusunController.text = widget.initialDusun!;
    }
    if (widget.initialRT != null) {
      widget.rtController.text = widget.initialRT!;
    }
    if (widget.initialRW != null) {
      widget.rwController.text = widget.initialRW!;
    }
    if (widget.initialJalan != null) {
      widget.jalanController.text = widget.initialJalan!;
    }
    if (widget.initialDesa != null) {
      widget.desaController.text = widget.initialDesa!;
    }
    if (widget.initialKecamatan != null) {
      widget.kecamatanController.text = widget.initialKecamatan!;
    }
    if (widget.initialKabupaten != null) {
      widget.kabupatenController.text = widget.initialKabupaten!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Alamat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: widget.dusunController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Dusun/Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan Dusun',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: TextFormField(
                        controller: widget.rtController,
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'RT',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: 'RT',
                          hintStyle: TextStyle(
                              color: Colors.black, fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    width: 100.0,
                    child: TextFormField(
                      controller: widget.rwController,
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'RW',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'RW',
                        hintStyle: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: widget.jalanController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Jalan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan Jalan',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: widget.desaController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Desa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan Desa',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: widget.kecamatanController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Kecamatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan Kecamatan',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: widget.kabupatenController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Kabupaten',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan Kabupaten',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () async {
                      final alamat = AlamatPenjual(
                        fkIdUser: widget.userId,
                        dusun: widget.dusunController.text,
                        rt: widget.rtController.text,
                        rw: widget.rwController.text,
                        jalan: widget.jalanController.text,
                        desa: widget.desaController.text,
                        kecamatan: widget.kecamatanController.text,
                        kabupaten: widget.kabupatenController.text,
                      );

                      await _alamatPenjualRepository
                          .getLatitudeLongitude(alamat);

                      // Memperbarui entri di database
                      await _alamatPenjualRepository
                          .insertOrUpdateAlamatPenjual(alamat);

                      widget.onSaveCallback();

                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: "Data Berhasil Diubah",
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Simpan'),
                  ),
                ],
              ), // Tambahkan jarak sebelum tombol logout
            ],
          ),
        ),
      ),
    );
  }
}
