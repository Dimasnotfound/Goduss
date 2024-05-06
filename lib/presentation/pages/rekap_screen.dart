import 'package:flutter/material.dart';
import '../widget/rekap_widget.dart';

class RekapScreen extends StatelessWidget {
  final int userId;

  const RekapScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text('Rekap Screen for User $userId'),
      ),
      floatingActionButton: RekapWidget(
        userId: userId, // Mengirimkan userId ke RekapWidget
        onPressed: () {
          // Tambahkan logika untuk tombol floating action di sini
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
