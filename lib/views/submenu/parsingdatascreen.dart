import 'package:flutter/material.dart';

// shortcut auto create ketik stfu, pilih paling atas

class ParsingDataScreen extends StatefulWidget {
  const ParsingDataScreen({super.key});

  @override
  State<ParsingDataScreen> createState() => _ParsingDataScreenState();
}

class _ParsingDataScreenState extends State<ParsingDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Parsing Data API'),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.blueAccent,
              iconTheme: IconThemeData(color: Colors.white),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'JSON RAW',
                    icon: Icon(Icons.data_array),
                  ),
                  Tab(
                    text: 'JSON Parse',
                    icon: Icon(Icons.data_usage),
                  ),
                  Tab(
                    text: 'API ReqRes',
                    icon: Icon(Icons.network_cell),
                  )
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.redAccent,
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(children: []),
          )),
    );
  }
}
