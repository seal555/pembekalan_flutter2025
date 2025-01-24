import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/utilities/sharedpreferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<StatefulWidget> {
  String username = "-";
  String token = "-";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ambil username dari SharedPreferences
    SharedPreferencesHelper.readUsername().then((value) {
      setState(() {
        username = value;
      });
    });

    // ambil token dari SharedPreferences
    SharedPreferencesHelper.readToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Menu'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    child: Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                'https://reqres.in/img/faces/8-image.jpg',
                                height: 80,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$username',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$token',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ))),
                Card(
                  color: Colors.amberAccent,
                  margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text('Dashboard Menu'),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    onTap: () {
                      // definisikan aksinya disini
                    },
                  ),
                ),
                Card(
                  color: Colors.amberAccent,
                  margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: ListTile(
                    leading: Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                    ),
                    title: Text('Adminstrator'),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    onTap: () {
                      // definisikan aksinya disini
                    },
                  ),
                ),
                Card(
                  color: Colors.amberAccent,
                  margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpansionTile(
                      title: Text(
                        'Settings',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      textColor: Colors.white,
                      backgroundColor: Colors.grey,
                      collapsedBackgroundColor: Colors.amberAccent,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Text(
                              'Pengaturan Bahasa',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            // tentukan aksinya
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                              Text(
                                'Pengaturan Theme',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Text(
                              'T&C',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: TextButton(
                onPressed: () {
                  // aksi jika button logout ditekan
                  logoutConfirmation(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.redAccent)),
              ),
            )
          ],
        ),
      ),
      body: DashboardScreenLayout(),
    );
  }

  void logoutConfirmation(BuildContext _context) {
    var confirmationDialog = CustomConfirmationDialog(
      title: 'Confirmation',
      message: 'Apakah Anda yakin ingin logout?',
      yes: 'Ya',
      no: 'Tidak',
      pressYes: () {
        // 1. mengganti flag isLogin menjadi false
        SharedPreferencesHelper.saveIsLogin(false);

        // 2. hilangkan konfirmasi
        Navigator.of(_context).pop();

        // 3. pindah ke login screen, tapi semua screen sebelumnya dihapus dari stack
        Navigator.pushReplacementNamed(_context, Routes.loginscreen);
      },
      pressNo: () {
        // tidak jadi logout
        Navigator.of(_context).pop();
      },
    );

    // tampilkan dialog konfirmasi
    showDialog(context: _context, builder: (_) => confirmationDialog);
  }
}

class DashboardScreenLayout extends StatefulWidget {
  @override
  DashboardScreenLayoutState createState() => DashboardScreenLayoutState();
}

class DashboardScreenLayoutState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      crossAxisCount: 2,
      children: [
        Card(
          color: Colors.orangeAccent,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.archive,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Parsing Data API',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen parsing
              Navigator.pushNamed(context, Routes.parsingdatascreen);
            },
          ),
        ),
        Card(
          color: Colors.lightGreen,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Imaging & Slider',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen imaging
              Navigator.pushNamed(context, Routes.imagingsliderscreen);
            },
          ),
        ),
        Card(
          color: Colors.pinkAccent,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Camera & Galery',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen camera & galery
              Navigator.pushNamed(context, Routes.cameragaleryscreen);
            },
          ),
        ),
        Card(
          color: Colors.blueAccent,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'SQLite Database',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen database
              Navigator.pushNamed(context, Routes.listmahasiswascreen);
            },
          ),
        ),
        Card(
          color: Colors.black38,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Location Services',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen location services
              Navigator.pushNamed(context, Routes.locationservicesscreen);
            },
          ),
        ),
        Card(
          color: Colors.indigo,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Map Service',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen map services
              Navigator.pushNamed(context, Routes.mapservicescreen);
            },
          ),
        ),
        Card(
          color: Colors.redAccent,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.scanner,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'OCR',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: (){
              // pindah ke screen OCR
              Navigator.pushNamed(context, Routes.ocrscreen);
            },
          ),
        )
      ],
    );
  }
}
