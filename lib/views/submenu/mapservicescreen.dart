import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pembekalan_flutter/customs/custom_compass_painter.dart';
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

  // menampung layout compass
  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    super.dispose();

    print('On Dispose...........');
    overlayEntry!.remove();
    print('Remove Compass...........');
  }

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

    // fitur extra, tambahkan compass
    showCompass(context);
  }

  void showCompass(BuildContext context) {
    final size = MediaQuery.of(context).size;

    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: size.height * 0.6,
            left: size.width * 0.2,
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: size.height * 0.3,
                width: size.width * 0.6,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: StreamBuilder(
                        stream: FlutterCompass.events,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                'Error reading heading: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // tangkap bacaan arah mata angin
                          double? direction = snapshot.data!.heading;

                          if (direction == null) {
                            return const Center(
                              child: Text('Device does not have sensors'),
                            );
                          } else {
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: size,
                                    painter:
                                        CustomCompassPainter(angle: direction),
                                  ),
                                  Text(
                                    buildArahMataAngin(direction),
                                    style: TextStyle(
                                        fontSize: 70, color: Colors.grey[700]!),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "${direction.toStringAsFixed(5)}",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ),
            )));

    // untuk menampilkan layout compass
    Overlay.of(context).insert(overlayEntry!);
  }

  String buildArahMataAngin(double direction) {

    //direction = direction.abs();

    if (direction >= 0 && direction <= 45 ||
        direction >= 315 && direction <= 360) {
      return 'N'; //utara
    } else if (direction > 45 && direction <= 135) {
      return 'E'; //timur
    } else if (direction > 135 && direction < 225) {
      return 'S'; //selatan
    } else if (direction > 225 && direction <= 315) {
      return 'W'; //barat
    } else {
      return "-";
    }
  }
}
