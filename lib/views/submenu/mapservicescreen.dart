import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapServiceScreen extends StatefulWidget {
  const MapServiceScreen({super.key});

  @override
  State<MapServiceScreen> createState() => _MapServiceScreenState();
}

class _MapServiceScreenState extends State<MapServiceScreen> {
  // lokasi default saat peta ditampilkan pertama kali
  CameraPosition initPosition = CameraPosition(
      target: LatLng(-6.1864688, 106.8296376), zoom: 12); // koordinat monas

  // marker untuk xa site jogja
  static Marker xaMarker = Marker(
      markerId: MarkerId('12345'),
      position: LatLng(-7.762404619006107, 110.39591861989523),
      infoWindow: InfoWindow(title: 'XSIS Dev Center Jogja'),
      onTap: () async {
        //membuka website xsis academy
        String url = 'https://www.xsis.co.id/xsis-academy/';

        await canLaunchUrl(Uri.parse(url))
            ? await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication)
            : throw 'Could not launch $url';
      });

    // referensi custom icon marker https://www.youtube.com/watch?v=RVtjQupsa9I  

  // koordinat XA Jogja
  CameraPosition xaCoordinate = CameraPosition(
      target: LatLng(-7.762404619006107, 110.39591861989523), zoom: 20);

  // controller map
  Completer<GoogleMapController> controllerMap = Completer();

  // semua marker yg akan ditampilkan ditampung di sini
  List<Marker> markers = <Marker>[];

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
        onMapCreated: (GoogleMapController controller) {
          // handle aksi pada peta
          controllerMap.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton.extended(
          onPressed: () {
            // pindah lokasi peta
            goToXSISJogja();
          },
          label: Text(
            'Go to XSIS Jogja',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.school,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigo,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Future<void> goToXSISJogja() async {
    final GoogleMapController controller = await controllerMap.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(xaCoordinate));

    setState(() {
      //tambahkan marker
      markers.add(xaMarker);
    });
  }
}
