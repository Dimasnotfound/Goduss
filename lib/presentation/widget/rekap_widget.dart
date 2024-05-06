import 'package:flutter/material.dart';
import '../viewmodel/rekap_viewmodel.dart';
import '../../data/models/alamat_pembeli.dart';
import '../../data/models/rekap.dart';
import '../../data/models/tracking.dart';

// Sesuaikan dengan path yang benar

class RekapWidget extends StatefulWidget {
  final int userId;
  final VoidCallback onPressed;

  const RekapWidget({Key? key, required this.userId, required this.onPressed})
      : super(key: key);

  @override
  _RekapWidgetState createState() => _RekapWidgetState();
}

class _RekapWidgetState extends State<RekapWidget> {
  final RekapViewModel _rekapViewModel =
      RekapViewModel(); // Instansiasi ViewModel
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dusunController = TextEditingController();
  TextEditingController _rtController = TextEditingController();
  TextEditingController _rwController = TextEditingController();
  TextEditingController _jalanController = TextEditingController();
  TextEditingController _desaController = TextEditingController();
  TextEditingController _kecamatanController = TextEditingController();
  TextEditingController _kabupatenController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _dusunController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _jalanController.dispose();
    _desaController.dispose();
    _kecamatanController.dispose();
    _kabupatenController.dispose();
    _namaController.dispose();
    _jumlahController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tambah Pembeli',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            labelText: 'Nama Pembeli',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _jumlahController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Jumlah Kambing',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _hargaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Harga Total',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Tanggal Pengiriman',
                              border: OutlineInputBorder(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _dateController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'Pilih Tanggal Pengiriman',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _showAddressDialog(context);
                          },
                          child: Text('Tambah Alamat'),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _savePembeli(); // Panggil fungsi simpan pembeli
                          },
                          child: Text('Simpan'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    _dateController.text = 'Pilih Tanggal'; // Set default text
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}';
      });
    }
  }

  Future<void> _showAddressDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Alamat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dusunController,
                decoration: InputDecoration(
                  labelText: 'Dusun/Alamat',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _rtController,
                decoration: InputDecoration(
                  labelText: 'RT',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _rwController,
                decoration: InputDecoration(
                  labelText: 'RW',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _jalanController,
                decoration: InputDecoration(
                  labelText: 'Jalan',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _desaController,
                decoration: InputDecoration(
                  labelText: 'Desa',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _kecamatanController,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _kabupatenController,
                decoration: InputDecoration(
                  labelText: 'Kabupaten',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveAlamat(); // Panggil fungsi simpan alamat
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAlamat() async {
    // Simpan alamat ke dalam database
    AlamatPembeli alamat = AlamatPembeli(
      dusun: _dusunController.text,
      rt: _rtController.text,
      rw: _rwController.text,
      jalan: _jalanController.text,
      desa: _desaController.text,
      kecamatan: _kecamatanController.text,
      kabupaten: _kabupatenController.text,
    );

    await _rekapViewModel.getLatitudeLongitude(alamat);
    Navigator.pop(
        context); // Panggil fungsi untuk mencari latitude dan longitude
  }

  void _savePembeli() async {
    AlamatPembeli alamat = AlamatPembeli(
      dusun: _dusunController.text,
      rt: _rtController.text,
      rw: _rwController.text,
      jalan: _jalanController.text,
      desa: _desaController.text,
      kecamatan: _kecamatanController.text,
      kabupaten: _kabupatenController.text,
    );

    await _rekapViewModel.getLatitudeLongitude(alamat);

    int alamatid = await _rekapViewModel.insertAlamat(alamat);
    print(alamatid);

    Rekap rekap = Rekap(
      idAlamatPembeli: alamatid,
      idStatusPengantaran: 1,
      namaPembeli: _namaController.text,
      tanggalPengantaran: _selectedDate,
      jumlahKambing: int.tryParse(_jumlahController.text) ?? 0,
      harga: double.tryParse(_hargaController.text) ?? 0,
    );

    int rekapid = await _rekapViewModel.insertRekap(rekap);

    Tracking tracking = Tracking(
      idUser: widget.userId,
      idAlamatPenjual: widget.userId,
      idAlamatPembeli: 1,
      idRekap: rekapid,
    );

    await _rekapViewModel.insertTracking(tracking);

    // Tambahkan logika untuk menyimpan pembeli di sini
    // Navigator.pop(context); // Tutup bottom sheet
  }
}
