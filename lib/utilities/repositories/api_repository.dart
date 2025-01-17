import 'dart:convert';

import 'package:pembekalan_flutter/utilities/networking/networking_response.dart';

import '../appconfiguration.dart';
import '../networking/networking_connector.dart';

class APIRepository {
  // semua request yg berhubungan dng API, definisikan disini

  // 1. API untuk get List Users
  Future<NetworkingResponse> getListUsers(int page) {
    String url = API_BASE_URL;

    Map<String, String> headerRequest = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    };

    Map<String, String> queryParameters = {'page': '$page'};

    return NetworkingConnector()
        .getRequest(url, END_POINT_LIST_USERS, headerRequest, queryParameters);
  }

  // 2. Login User
  Future<NetworkingResponse> loginUser(String email, String password) {
    String url = API_BASE_URL + END_POINT_LOGIN_USER;

    Map<String, String> headerRequest = {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    };

    final bodyRequest = jsonEncode({"email": email, "password": password});

    return NetworkingConnector().postRequest(url, headerRequest, bodyRequest);
  }
}
