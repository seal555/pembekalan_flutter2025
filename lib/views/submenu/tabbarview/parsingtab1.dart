import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParsingTab1 extends StatefulWidget {
  const ParsingTab1({super.key});

  @override
  State<ParsingTab1> createState() => _ParsingTab1State();
}

class _ParsingTab1State extends State<ParsingTab1>
    with AutomaticKeepAliveClientMixin {
  String jsonResult = '';
  int responseCode = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              // panggil API
              get100Posts();
            },
            child: Text('Get 100 Post'),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black12)),
          ),
          SizedBox(
            height: 10,
          ),
          Text('HTTP Response Code = $responseCode'),
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(10),
            children: [Text('$jsonResult')],
          ))
        ],
      ),
    );
  }

  // method utk ngobrol dng API
  Future<String?> get100Posts() async {
    // url API
    final String urlAPI = 'https://jsonplaceholder.typicode.com/posts';

    var request = await http.get(Uri.parse(urlAPI), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    });

    // menangkap response
    var response = request.body;
    print('Hasil baca API = $response');

    setState(() {
      jsonResult = request.body;
      responseCode = request.statusCode;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
