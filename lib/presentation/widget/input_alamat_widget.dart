import 'package:flutter/material.dart';

class InputAlamat extends StatefulWidget {
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

  const InputAlamat({
    Key? key,
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
  }) : super(key: key);

  @override
  _InputAlamatState createState() => _InputAlamatState();
}

class _InputAlamatState extends State<InputAlamat> {
  @override
  void initState() {
    super.initState();
    if (widget.initialDusun != null)
      widget.dusunController.text = widget.initialDusun!;
    if (widget.initialRT != null) widget.rtController.text = widget.initialRT!;
    if (widget.initialRW != null) widget.rwController.text = widget.initialRW!;
    if (widget.initialJalan != null)
      widget.jalanController.text = widget.initialJalan!;
    if (widget.initialDesa != null)
      widget.desaController.text = widget.initialDesa!;
    if (widget.initialKecamatan != null)
      widget.kecamatanController.text = widget.initialKecamatan!;
    if (widget.initialKabupaten != null)
      widget.kabupatenController.text = widget.initialKabupaten!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: TextFormField(
                  controller: widget.dusunController,
                  style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Masukkan Dusun',
                    hintStyle:
                        TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
                controller: widget.rtController,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'RT',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'RW',
                  hintStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Masukkan Jalan',
            hintStyle: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Masukkan Desa',
            hintStyle: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Masukkan Kecamatan',
            hintStyle: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Masukkan Kabupaten',
            hintStyle: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }
}
