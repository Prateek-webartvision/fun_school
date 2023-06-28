abstract class KException {
  final int errorCode;
  final String errorMessage;

  KException({required this.errorCode, required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class KInternetException extends KException {
  final int code = 1;
  String? message;

  KInternetException({this.message = "No Internet Connection"}) : super(errorCode: 1, errorMessage: message!);
}

class KRequestTimeOutException extends KException {
  final int code = 2;
  String? message;

  KRequestTimeOutException({this.message = "Request Time Out"}) : super(errorCode: 1, errorMessage: message!);
}
