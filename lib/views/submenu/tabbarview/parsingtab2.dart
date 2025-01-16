import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ParsingTab2 extends StatefulWidget {
  const ParsingTab2({super.key});

  @override
  State<ParsingTab2> createState() => _ParsingTab2State();
}

class _ParsingTab2State extends State<ParsingTab2>
    with AutomaticKeepAliveClientMixin {
  int responseCode = 0;
  List? dataUsers;

  ProgressDialog? loading;

  @override
  Widget build(BuildContext context) {
    // init loading
    loading = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    loading!.style(
        message: 'Mohon tunggu.......',
        progressWidget: CircularProgressIndicator(),
        borderRadius: 10,
        elevation: 10,
        insetAnimCurve: Curves.easeInOut);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              // panggil API
              get10Users();
            },
            child: Text(
              'Get 10 Users',
            ),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent)),
          ),
          SizedBox(
            height: 10,
          ),
          Text('HTTP Response Code = $responseCode'),
          Expanded(
              child: ListView.builder(
                  itemCount: dataUsers == null ? 0 : dataUsers!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: InkWell(
                        child: Card(
                          color: index % 2 == 0
                              ? Colors.white24
                              : Colors.amberAccent,
                          margin: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${dataUsers![index]['name']} (${dataUsers![index]['username']})',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Email : ${dataUsers![index]['email']}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Address : ${dataUsers![index]['address']['street']} ${dataUsers![index]['address']['suite']} ${dataUsers![index]['address']['city']} ZIP CODE : ${dataUsers![index]['address']['zipcode']}',
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          // jika di tap munculkan info lat long dalam bentuk snackbar
                          actionTap(index);
                        },
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void actionTap(int index) {
    String lat = dataUsers![index]['address']['geo']['lat'];
    String lng = dataUsers![index]['address']['geo']['lng'];
    String username = dataUsers![index]['username'];

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$username ($lat, $lng)',
          style: TextStyle(color: Colors.white, fontSize: 16)),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blueAccent,
    ));
  }

  Future<String?> get10Users() async {
    //tampilkan loading
    await loading!.show();

    final String urlAPI = 'https://jsonplaceholder.typicode.com/users';

    var request = await http.get(Uri.parse(urlAPI), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    });

    var response = request.body;
    print('Hasil baca dari API = $response');

    setState(() {
      responseCode = request.statusCode;

      // konversi dari response API menjadi format JSON yg dikenali Flutter
      // supaya bisa diparsing datanya
      dataUsers = json.decode(response);

      loading!.hide();
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
