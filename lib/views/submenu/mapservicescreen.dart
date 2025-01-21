import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServiceScreen extends StatefulWidget {
  const MapServiceScreen({super.key});

  @override
  State<MapServiceScreen> createState() => _MapServiceScreenState();
}

class _MapServiceScreenState extends State<MapServiceScreen> {
  // lokasi default saat peta ditampilkan pertama kali
  CameraPosition initPosition = CameraPosition(
      target: LatLng(-6.1864688, 106.8296376), zoom: 12); // koordinat monas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Services'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        initialCameraPosition: initPosition,
        mapType: MapType.normal,
      ),
    );
  }
}
