//stf shorcut
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
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
  int page = 1;
  int maxPage = 1;

  // untuk handling pergerakan scroll pada layar
  ScrollController scrollController = new ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // ini artinya scroll sudah mentok bawah
        loadMoreData();
      }
    });
  }

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
                getListUsers(page);
              },
              child: Text('Get List Users'),
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.deepOrangeAccent)),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: dataUsers.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == dataUsers.length) {
                  return loadingIndicator();
                } else {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        // aksi tap
                        showInfoUser(dataUsers[index]);
                      },
                      child: Card(
                        color:
                            index % 2 == 0 ? Colors.white : Colors.amberAccent,
                        margin: EdgeInsets.fromLTRB(5, 30, 5, 30),
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
                }
              },
              controller: scrollController,
            ))
          ]),
    );
  }

  void getListUsers(int page) async {
    setState(() {
      // tampilkan loading
      isLoading = true;
    });

    // panggil API get list users dng parameter page
    // referensi:
    // https://www.dicoding.com/blog/tips-design-pattern-mvvm/
    // https://revou.co/kosakata/mvvm
    // https://ahmadsufyan.my.id/mvvm/

    ListUsersViewmodel().getDataFromAPI(context, page).then((value) {
      setState(() {
        // hilangkan loading
        isLoading = false;

        if (value != null) {
          print('Debug : $value');

          // maximum page
          maxPage = value.totalPages;

          if (page == 1) {
            // data awal kosong, isi data
            dataUsers = value.data;
          } else {
            // sudah ada data sebelumnya, tambah data baru
            dataUsers.addAll(value.data);
          }
        }
      });
    });
  }

  void loadMoreData() {
    print('Load more dipanggil $page');
    if (dataUsers.isNotEmpty && page < maxPage) {
      // ambil data selanjutnya
      page += 1;
      getListUsers(page);
    } else {
      // sudah maksimal, tidak ada baru
    }
  }

  Widget loadingIndicator() {
    // loading tipe load more
    return Padding(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Opacity(
            opacity: isLoading ? 1.0 : 0.0, child: CircularProgressIndicator()),
      ),
    );
  }

  void showInfoUser(Data info){
    String message = '${info.firstName} ${info.lastName}';
    ScaffoldMessenger.of(context).showSnackBar(customSnackbar(message));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
