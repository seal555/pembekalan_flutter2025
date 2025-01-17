import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/models/list_users_model.dart';
import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';

import '../customs/custom_snackbar.dart';
import '../utilities/networking/response_unsuccess.dart';
import '../utilities/repositories/api_repository.dart';

class ListUsersViewmodel {
  ListUsersViewmodel();

  Future<ListUsersModel?> getDataFromAPI(BuildContext context, int page) async {
    // connect API
    NetworkingResponse response = await APIRepository().getListUsers(page);

    if (response is NetworkingSuccess) {
      if (response.statusCode == 200) {
        // proses konversi dari response jadi model
        ListUsersModel model = ListUsersModel.fromJson(json.decode(response.body));
        return model;
      } else {
        // selain code 200, silahkan handle disini aksinya apa
        print('Status Code : ${response.statusCode}');
        print('Message : ${response.body}');

        ResponseUnsuccess responseUnsuccess =
            responseUnsuccessFromJson(response.body);
        String message = '$responseUnsuccess.message [${response.statusCode}]';

        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackbar(message));
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
