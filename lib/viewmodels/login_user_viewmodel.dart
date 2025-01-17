import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/models/login_user_model.dart';
import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';
import 'package:pembekalan_flutter/utilities/repositories/api_repository.dart';

import '../customs/custom_snackbar.dart';
import '../utilities/networking/response_unsuccess.dart';

class LoginUserViewmodel {
  LoginUserViewmodel();

  Future<LoginUserModel?> postDataToAPI(
      BuildContext context, String email, String password) async {
    NetworkingResponse response =
        await APIRepository().loginUser(email, password);

    if (response is NetworkingSuccess) {
      if (response.statusCode == 200) {
        // login sukses, dapat token
        LoginUserModel model =
            LoginUserModel.fromJson(jsonDecode(response.body));
        return model;
      } else if (response.statusCode == 400) {
        //login gagal
        print('Status Code : ${response.statusCode}');
        print('Message : ${response.body}');

        var error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(error));
        return null;
      } else {
        // selain code 200 & 400, silahkan handle disini aksinya apa
        print('Status Code : ${response.statusCode}');
        print('Message : ${response.body}');

        ResponseUnsuccess responseUnsuccess =
            responseUnsuccessFromJson(response.body);
        String message = '$responseUnsuccess.message [${response.statusCode}]';

        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(message));
        return null;
      }
    } else if (response is NetworkingException) {
      // something wrong
      // informasikan ke users apa problemnya
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar(response.message));
      return null;
    }
    return null;
  }
}
