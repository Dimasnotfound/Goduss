import 'package:flutter/material.dart';
import 'widgetakun.dart';

class AkunWidget extends StatelessWidget {
  final int userId;
  final Map<String, dynamic> akunData;
  final VoidCallback onSaveCallback; // Tambahkan properti akunData

  const AkunWidget({Key? key, required this.userId, required this.akunData,required this.onSaveCallback,})
      : super(key: key); // Ubah konstruktor untuk menerima akunData

  @override
  Widget build(BuildContext context) {
    final userData = akunData['user'];
    final alamatPenjual = akunData['alamat_penjual'];
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Image.asset(
              'assets/akun1.png',
              width: 348,
              height: 477,
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: (MediaQuery.of(context).size.width - 285) / 2,
          child: Column(
            children: [
              buildInfoContainer(
                imageAsset: 'assets/username.png',
                title: 'Username',
                subtitle: '${userData['username']}',
                onEditPressed: () {
                  // Fungsi yang akan dipanggil saat tombol edit ditekan
                  // Di sini Anda bisa menampilkan dialog atau layar edit
                },
              ),
              SizedBox(
                  height: 20), // Penambahan jarak di antara kedua container
              buildInfoContainer(
                imageAsset: 'assets/alamat.png',
                title: 'Alamat',
                subtitle:
                    '${alamatPenjual.jalan},${alamatPenjual.kecamatan},${alamatPenjual.kabupaten}',
                showEditButton: true,
                onEditPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: Color(0xFF215CA8),
                              width: 3.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    700, // Sesuaikan dengan tinggi yang diinginkan
                                maxWidth:
                                    300, // Sesuaikan dengan lebar yang diinginkan
                              ),
                              child: SingleChildScrollView(
                                child: InputAlamat(
                                  userId: userId,
                                  dusunController: TextEditingController(
                                      text: alamatPenjual.dusun),
                                  rtController: TextEditingController(
                                      text: alamatPenjual.rt),
                                  rwController: TextEditingController(
                                      text: alamatPenjual.rw),
                                  jalanController: TextEditingController(
                                      text: alamatPenjual.jalan),
                                  desaController: TextEditingController(
                                      text: alamatPenjual.desa),
                                  kecamatanController: TextEditingController(
                                      text: alamatPenjual.kecamatan),
                                  kabupatenController: TextEditingController(
                                      text: alamatPenjual.kabupaten),
                                  onSaveCallback: onSaveCallback,
                                ),
                              )));
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 160,
          left: 145,
          child: Image.asset(
            'assets/PROFIL.png',
            fit: BoxFit.cover,
            height: 25,
          ),
        ),
      ],
    );
  }

  Widget buildInfoContainer({
    required String imageAsset,
    required String title,
    required String subtitle,
    bool showEditButton =
        false, // Tambahkan properti untuk menampilkan tombol edit
    required VoidCallback? onEditPressed, // VoidCallback bersifat opsional
  }) {
    return Container(
      width: 285,
      height: 119,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              imageAsset,
              width: 44,
              height: 46,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35), // Penambahan jarak ke bawah
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2), // Penambahan jarak ke bawah
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis, // Menambahkan overflow
                ),
              ],
            ),
          ),
          if (showEditButton) // Tampilkan tombol edit jika properti showEditButton true
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEditPressed,
            ),
        ],
      ),
    );
  }
}
