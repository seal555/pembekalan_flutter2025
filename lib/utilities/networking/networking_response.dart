class NetworkingResponse {
  // berfungsi sebagai callback sukses
  // callback error/exception
}

class NetworkingException extends NetworkingResponse{
  String message;

  NetworkingException(this.message);
}

class NetworkingSuccess extends NetworkingResponse{
  String body;
  int statusCode;

  NetworkingSuccess(this.body, this.statusCode);
}