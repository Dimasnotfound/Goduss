import 'package:flutter/material.dart';
import '../widget/akun_widget.dart';
import '../viewmodel/akun_viewmodel.dart'; // Sesuaikan dengan lokasi AkunViewModel

class AkunScreen extends StatefulWidget {
  final int userId;

  const AkunScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  late Map<String, dynamic> akunData;
  late AkunViewModel _akunViewModel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _akunViewModel = AkunViewModel(userId: widget.userId);
    _loadAkunData();
  }

  Future<void> _loadAkunData() async {
    final data = await _akunViewModel.getAkunData();
    setState(() {
      akunData = data;
      _isLoading = false;
      print(data); // Setelah data dimuat, set isLoading menjadi false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Menampilkan spinner jika masih loading
          : AkunWidget(
              userId: widget.userId,
              akunData: akunData,
              onSaveCallback: _loadAkunData,
            ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Row(
            children: [
              Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)), // Warna ikon
              SizedBox(width: 5), // Jarak antara ikon dan teks
              Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Poppins', // Font Poppins
                  fontWeight: FontWeight.bold, // Tebal
                  color: Color(0xFFFFFFFF), // Warna teks
                  fontSize: 18, // Ukuran teks
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red, // Warna latar belakang transparan
          elevation: 7, // Menghapus box shadow
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Sisipkan kode lainnya di sini
    );
  }
}
