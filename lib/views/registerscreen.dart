import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<StatefulWidget> {
  int genderRadioValue = -1;

  List itemPekerjaan = [
    'Designer',
    'Analyst',
    'Programmer',
    'Software Tester',
    'Project Manager',
    'SCRUM Master PMO',
    'Database Engineer',
    'Prompt Engineer'
  ];
  String? valuePekerjaan;

  List itemPendidikan = ['SD', 'SMP', 'SMA', 'D3', 'S1', 'S2', 'S3'];
  String? valuePendidikan;

  List itemHobi = [
    'Renang',
    'Baca Buku',
    'Lari',
    'Sepeda',
    'Touring',
    'Hiking',
    "Traveling",
    'Kuliner'
  ];
  String? valueHobi;

  DateTime tanggalTerpilih = DateTime.now();
  String? tanggalLahir = 'Belum Dipilih';
  bool agreeValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.lightBlue,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Form'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: Colors.blueAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Nama Lengkap Anda',
                      hintStyle: TextStyle(color: Colors.orangeAccent)),
                  maxLength: 50,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Usia Anda',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Alamat Lengkap',
                      hintStyle: TextStyle(color: Colors.orangeAccent)),
                  maxLength: 120,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Nomor Telepon',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''),
                  maxLength: 16,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''),
                  maxLength: 16,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Kelamin'),
                    Row(
                      children: [
                        Radio(
                            value: 0,
                            groupValue: genderRadioValue,
                            onChanged: handleClickRadio),
                        Text('Laki-Laki'),
                        Radio(
                            value: 1,
                            groupValue: genderRadioValue,
                            onChanged: handleClickRadio),
                        Text('Perempuan'),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Pekerjaan'),
                    Container(
                      width: size.width,
                      child: ButtonTheme(
                        child: DropdownButton(
                          items: itemPekerjaan.map((kerjaan) {
                            return DropdownMenuItem(
                                child: Text(kerjaan), value: kerjaan);
                          }).toList(),
                          onChanged: (value) {
                            // aksi
                            setState(() {
                              valuePekerjaan = value.toString();
                            });
                          },
                          hint: Text('-silahkan pilih-'),
                          isExpanded: true,
                          value: valuePekerjaan,
                        ),
                        alignedDropdown: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pendidikan'),
                    DropdownButton(
                      items: itemPendidikan.map((pendidikan) {
                        return DropdownMenuItem(
                            child: Text(pendidikan), value: pendidikan);
                      }).toList(),
                      onChanged: (value) {
                        // aksi
                        setState(() {
                          valuePendidikan = value.toString();
                        });
                      },
                      hint: Text('-silahkan pilih-'),
                      isExpanded: false,
                      value: valuePendidikan,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hobi Anda'),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.lightGreen),
                      child: ButtonTheme(
                        child: DropdownButton(
                          items: itemHobi.map((hobi) {
                            return DropdownMenuItem(
                                child: Text(hobi), value: hobi);
                          }).toList(),
                          onChanged: (value) {
                            // aksi
                            setState(() {
                              valueHobi = value.toString();
                            });
                          },
                          hint: Text('-silahkan pilih-'),
                          isExpanded: true,
                          value: valueHobi,
                          iconEnabledColor: Colors.white,
                        ),
                        alignedDropdown: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih Tanggal Lahir'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // aksi jika iconbutton di tekan
                              pilihTanggalLahir(context);
                            },
                            icon: Icon(Icons.calendar_today)),
                        Text(
                          '$tanggalLahir',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Text(
                    'Dengan melakukan registrasi, berarti Anda telah menyetujui segala syarat dan ketentuan yang berlaku pada aplikasi kami. Silahkan centang jika Anda setuju.'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  value: agreeValue,
                  onChanged: (newValue) {
                    setState(() {
                      agreeValue = newValue!;
                    });
                  },
                  title: Text('Saya Setuju'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: agreeValue ? () => sayaSetuju() : null,
                  child: Text('Register Now!'))
            ],
          ),
        ),
      ),
    );
  }

  void sayaSetuju(){
    Navigator.of(context).pop();
  }

  void pilihTanggalLahir(BuildContext _context) async {
    print('tampilkan datetime picker');
    final DateTime? picker = await showDatePicker(
        context: _context,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());

    if (picker != null && picker != tanggalTerpilih) {
      setState(() {
        tanggalTerpilih = picker;

        //konversi dari DateTime menjadi String
        //dd-MM-yyyy
        tanggalLahir = DateFormat('dd-MM-yyyy').format(tanggalTerpilih);
      });
    }
  }

  void handleClickRadio(int? value) {
    setState(() {
      genderRadioValue = value!;
      print('Nilai radio button = $genderRadioValue');
    });
  }
}
