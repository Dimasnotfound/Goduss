import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../viewmodel/tracking_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'components/InfoWidget.dart';

class WidgetTrackingScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const WidgetTrackingScreen({Key? key, this.latitude, this.longitude})
      : super(key: key);

  @override
  _WidgetTrackingScreenState createState() => _WidgetTrackingScreenState();
}

class _WidgetTrackingScreenState extends State<WidgetTrackingScreen> {
  late TrackingViewModel _viewModel;
  TextEditingController? _controller; // Menghapus late

  int _muatan = 0; // Definisikan _muatan

  @override
  void initState() {
    super.initState();
    _viewModel = TrackingViewModel(
      context: context,
      latitude: widget.latitude,
      longitude: widget.longitude,
      markerMap: {},
    );

    _controller = TextEditingController(); // Menginisialisasi _controller
    _viewModel.getRoute().then((_) {
      setState(() {
        // Tidak ada _isLoading lagi yang digunakan di sini
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () async {
                    await _viewModel.selectDate();
                    setState(
                        () {}); // Memperbarui tampilan setelah pemilihan tanggal
                  },
                  label: Text(
                    _viewModel.selectedDate != null
                        ? "${_viewModel.selectedDate!.day.toString()}-${_viewModel.selectedDate!.month.toString()}-${_viewModel.selectedDate!.year.toString()}"
                        : 'Pilih Tanggal',
                    style: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.calendar_today),
                  elevation: 10,
                  tooltip: 'Select Date',
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                SizedBox(width: 8.0),
                FloatingActionButton.extended(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Tambah Muatan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          backgroundColor: Color(0xFF215CA8),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 47.0,
                                    height: 65.0,
                                    child: Image.asset(
                                      'assets/baphomet1.png',
                                      width: 47,
                                      height: 65,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      elevation: 7,
                                    ),
                                    child: Text(
                                      "Batal",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _muatan = int.parse(_controller!.text);
                                      });
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.success(
                                          message: "Data Berhasil Diubah",
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      elevation: 7,
                                    ),
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  label: Column(
                    children: [
                      Text(
                        'Muatan',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        _muatan.toString(), // Menggunakan _muatan di sini
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                  icon: Image.asset(
                    'assets/baphomet.png',
                    width: 25,
                    height: 42,
                  ),
                  elevation: 10,
                  backgroundColor: Color(0xFF215CA8),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                          widget.latitude ?? 0.0, widget.longitude ?? 0.0),
                      initialZoom: 17.0,
                      interactionOptions: const InteractionOptions(
                          flags: ~InteractiveFlag.doubleTapZoom),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      MarkerLayer(
                        markers: _viewModel.markerMap.entries
                            .map((entry) => Marker(
                                  point: entry.key,
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.centerLeft,
                                  child: InfoWidget(
                                    infoText: 'Marker Info',
                                    topLeftText: 'Top Left Text',
                                    bottomLeftText: 'Bottom Left Text',
                                    iconAsset: 'assets/goat.png',
                                    markerChild: Icon(
                                      Icons.location_on,
                                      size: 60,
                                      color: Colors.green,
                                    ),
                                    markerPosition: LatLng(
                                        widget.latitude ?? 0.0,
                                        widget.longitude ?? 0.0),
                                  ),
                                ))
                            .toList(),
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(widget.latitude ?? 0.0,
                                widget.longitude ?? 0.0),
                            width: 60,
                            height: 60,
                            alignment: Alignment.centerLeft,
                            child: InfoWidget(
                              infoText: 'Marker Info',
                              topLeftText: 'Top Left Text',
                              bottomLeftText: 'Bottom Left Text',
                              iconAsset: 'assets/goat.png',
                              markerChild: Icon(
                                Icons.location_on,
                                size: 60,
                                color: Colors.red,
                              ),
                              markerPosition: LatLng(widget.latitude ?? 0.0,
                                  widget.longitude ?? 0.0),
                            ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _viewModel.routpoints,
                            color: Colors.blue,
                            strokeWidth: 9,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
}
