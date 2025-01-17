import 'dart:convert';

ResponseUnsuccess responseUnsuccessFromJson(String str) =>
    ResponseUnsuccess.fromJson(json.decode(str));

String responseUnsuccessToJson(ResponseUnsuccess data) =>
    json.encode(data.toJson());

class ResponseUnsuccess {
  String? message;

  ResponseUnsuccess({this.message});

  // sesuaikan dng key 'message error' dari dokumentasi API masing-masing

  factory ResponseUnsuccess.fromJson(Map<String, dynamic> json) =>
      ResponseUnsuccess(message: json['message']);

  Map<String, dynamic> toJson() => {'message': message};
}
