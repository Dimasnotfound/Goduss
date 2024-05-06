import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/database/database.dart';
import '../viewmodel/login_viewmodel.dart';
import '../pages/init_alamat_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository(DatabaseProvider.instance);
    final loginViewModel = LoginViewModel(userRepository: userRepository);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            'assets/eclipse_login_top.png', // Ubah dengan path gambar Anda
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
          top: 120,
          left: 0,
          child: Center(
            child: Image.asset(
              'assets/LOGIN.png', // Ubah dengan path gambar Anda
              width: 200, // Sesuaikan dengan kebutuhan
              height: 200, // Sesuaikan dengan kebutuhan
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            'assets/eclipse_login_bottom.png', // Ubah dengan path gambar Anda
            // Sesuaikan tinggi gambar sesuai kebutuhan
            fit: BoxFit.cover, // Sesuaikan dengan kebutuhan
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                style: const TextStyle(
                  fontFamily: 'Poppins', // Font Poppins
                  fontSize: 18,
                  color: Color(0xFFFFFFFF), // Warna teks
                ),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15), // Atur padding untuk input field
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins', // Font Poppins
                    fontSize: 20,
                    color: Color(0xFFFFFFFF), // Warna teks label
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Garis bawah putih
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Garis bawah putih saat fokus
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                style: const TextStyle(
                  fontFamily: 'Poppins', // Font Poppins
                  fontSize: 18,
                  color: Color(0xFFFFFFFF), // Ukuran teks
                ),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15), // Atur padding untuk input field
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins', // Font Poppins
                    fontSize: 20,
                    color: Color(0xFFFFFFFF), // Warna teks label
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Garis bawah putih
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Garis bawah putih saat fokus
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    UserModel? user = await loginViewModel.loginUser(
                        _usernameController.text.trim(),
                        _passwordController.text.trim());
                    if (user != null) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: "Login Berhasil",
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InitAlamatScreen(
                            idUser: user.id,
                          ),
                        ),
                      );
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: "Data Tidak Valid",
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFFFFFFF), // Warna latar belakang putih
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Color(
                          0xFF215CA8), // Warna teks biru sesuai kode yang diberikan
                      fontFamily: 'Poppins', // Menggunakan font Poppins
                      fontWeight: FontWeight.w600, // Berat font menjadi bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 0.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Row(
            children: [
              Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)), // Warna ikon
              SizedBox(width: 5), // Jarak antara ikon dan teks
              Text(
                'Back',
                style: TextStyle(
                  fontFamily: 'Poppins', // Font Poppins
                  fontWeight: FontWeight.bold, // Tebal
                  color: Color(0xFFFFFFFF), // Warna teks
                  fontSize: 18, // Ukuran teks
                ),
              ),
            ],
          ),
          backgroundColor:
              Colors.transparent, // Warna latar belakang transparan
          elevation: 0, // Menghapus box shadow
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
