import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pembekalan_flutter/customs/custom_alertdialog.dart';
import 'package:pembekalan_flutter/utilities/sharedpreferences.dart';
import 'package:pembekalan_flutter/viewmodels/login_user_viewmodel.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/registerscreen.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  bool isRememberMe = false;

  final TextEditingController _controllerUsername = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();

  ProgressDialog? loading;
  SimpleFontelicoProgressDialog? loading2;

  // fungsi check isRememberMe
  @override
  void initState() {
    super.initState();

    // periksa flag IsRememberMe
    SharedPreferencesHelper.readIsRemember().then((value) {
      if (value) {
        // auto fill utk username & password
        SharedPreferencesHelper.readUsername().then((usr) {
          setState(() {
            _controllerUsername.text = usr;
            username = usr;
          });
        });
        SharedPreferencesHelper.readPassword().then((pwd) {
          setState(() {
            _controllerPassword.text = pwd;
            password = pwd;
          });
        });

        // centang IsRememberMe jika diperlukan
        setState(() {
          isRememberMe = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // mengetahui ukuran layar (width & height)
    Size size = MediaQuery.of(context).size;

    //init loading
    loading = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    loading!.style(
        message: 'Login, silahkan tunggu...',
        progressWidget: CircularProgressIndicator(),
        borderRadius: 10,
        elevation: 10,
        insetAnimCurve: Curves.easeInOut);

    loading2 = SimpleFontelicoProgressDialog(context: context);

    // TODO: implement build
    return Container(
      color: Colors.grey,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            /*
              tambahkan behavior: HitTestBehavior.opaque,
              kemudian gunakan FocusScope.of(context).unfocus();
              rekomendasi dari ChatGPT
            */
            FocusScope.of(context).unfocus(); //<Flutter 2
            // FocusManager.instance.primaryFocus?.unfocus(); //>= Flutter 2
            // FocusScope.of(context).requestFocus(FocusNode());
            // SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Container(
            width: size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/logo_xa.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login Form',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextField(
                        controller: _controllerUsername,
                        onChanged: (value) {
                          // set value ke variable
                          username = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Input Username',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextField(
                        controller: _controllerPassword,
                        onChanged: (value) {
                          // set value ke variable
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Input Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder()),
                        obscureText: true,
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                    child: CheckboxListTile(
                      value: isRememberMe,
                      onChanged: (newValue) {
                        // action handler
                        setState(() {
                          isRememberMe = newValue!;
                        });
                      },
                      title: Text('Remember Me'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // aksi jika tombol login di tekan
                      FocusScope.of(context).unfocus();
                      validasiLogin();
                    },
                    child: Text('Login Now!'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors
                            .black12), //WidgetStateProperty.all(Colors.redAccent)) -> gunakan ini saja
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.lightBlue;
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.blueAccent;
                          }
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black12;
                          }
                          return Colors.grey;
                        })),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Text(
                      'New Member? Register Now!',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // pindah ke screen register
                      pindahKeRegisterScreen();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pindahKeRegisterScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return RegisterScreen();
    }));
  }

  validasiLogin() {
    //sudah input username atau belum
    if (_controllerUsername.value.text.length == 0 || username.length == 0) {
      showAlert(context, 'Warning!', 'Anda belum mengisi username!');
    } else if (_controllerPassword.value.text.length == 0 ||
        password.length == 0) {
      showAlert(context, 'Warning!', 'Anda belum mengisi password!');
    } else {
      //sudah valid
      /*
      //simpan data secara offline (belum connect API)
      saveDataOffline(context, _controllerUsername.value.text,
          _controllerPassword.value.text, isRememberMe);*/

      // menggunakan API
      loginUser(context, _controllerUsername.value.text,
          _controllerPassword.value.text, isRememberMe);
    }
  }

  Future loginUser(BuildContext _context, String email, String password,
      bool isRememberMe) async {
    //username = eve.holt@reqres.in
    //password = cityslicka

    // tampilkan loading
    //await loading!.show();
    loading2!.show(
        message: 'Memproses login....',
        type: SimpleFontelicoProgressDialogType.hurricane);

    LoginUserViewmodel().postDataToAPI(_context, email, password).then((value) {
      // tutup loading
      //if(loading!.isShowing()) loading!.hide();
      //loading2!.hide();
      /*
      jika di hide maka jadi blocker, loading tidak hilang
      jika tidak di hide, maka otomatis loading hilang sendiri dan proses lanjut
      */

      setState(() {
        if (value != null) {
          // ambil token
          String token = value.token;

          saveDataOffline(_context, email, password, isRememberMe, token);
        }
      });
    });
  }

  saveDataOffline(BuildContext _context, String _username, String _password,
      bool _isRememberMe, String token) {
    // cara simpan data local
    SharedPreferencesHelper.saveUsername(_username);
    SharedPreferencesHelper.savePassword(_password);
    SharedPreferencesHelper.saveIsRemember(_isRememberMe);

    // flag login = true
    SharedPreferencesHelper.saveIsLogin(true);

    // simpan token
    SharedPreferencesHelper.saveToken(token);

    // ke DashboardScreen
    Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (_) {
      return DashboardScreen();
    }));
  }

  showAlert(BuildContext _context, String _title, String _message) {
    var alertDialog =
        CustomAlertDialog(title: _title, message: _message, action_text: "OK");

    showDialog(context: _context, builder: (_) => alertDialog);
  }
}
