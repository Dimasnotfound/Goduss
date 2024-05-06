import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF215CA8),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: -60,
            child: Image.asset(
              "assets/eclipse_screen_top.png", // Ganti dengan path gambar pertama
              width: 250, // Sesuaikan lebar gambar
              height: 250, // Sesuaikan tinggi gambar
            ),
          ),
          // Gambar kedua (di kiri bawah)
          Positioned(
            bottom: 0,
            left: -60,
            child: Image.asset(
              "assets/eclipse_screen_bottom.png", // Ganti dengan path gambar kedua
              width: 250, // Sesuaikan lebar gambar
              height: 250, // Sesuaikan tinggi gambar
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFD9D9D9)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginScreen()), // Navigasi ke halaman login saat tombol ditekan
                  );
                },
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF215CA8),
                  ),
                ),
              ),
            ),
          ),

          // Gambar ketiga (di tengah)
          Center(
            child: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/splash_screen_img.png"),
                  const SizedBox(
                      height: 20), // Tambahkan jarak antara gambar dan tombol
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
