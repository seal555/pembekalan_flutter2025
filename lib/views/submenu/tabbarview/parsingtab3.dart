//stf shorcut
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/models/list_users_model.dart';
import 'package:pembekalan_flutter/viewmodels/list_users_viewmodel.dart';

class ParsingTab3 extends StatefulWidget {
  const ParsingTab3({super.key});

  @override
  State<ParsingTab3> createState() => _Parsingtab3State();
}

class _Parsingtab3State extends State<ParsingTab3>
    with AutomaticKeepAliveClientMixin {
  List<Data> dataUsers = List<Data>.empty();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // get data
                getListUsers(1);
              },
              child: Text('Get List Users'),
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.deepOrangeAccent)),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: dataUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            // aksi tap
                          },
                          child: Card(
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.amberAccent,
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(dataUsers[index].avatar),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${dataUsers[index].firstName} ${dataUsers[index].lastName}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${dataUsers[index].email}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
          ]),
    );
  }

  void getListUsers(int page) async {
    // panggil API get list users dng parameter page
    // referensi:
    // https://www.dicoding.com/blog/tips-design-pattern-mvvm/
    // https://revou.co/kosakata/mvvm
    // https://ahmadsufyan.my.id/mvvm/

    ListUsersViewmodel().getDataFromAPI(context, page).then((value) {
      setState(() {
        if (value != null) {
          print('Debug : $value');

          dataUsers = value.data;
        }
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
