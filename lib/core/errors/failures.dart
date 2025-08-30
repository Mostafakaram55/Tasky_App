import 'package:dio/dio.dart';
abstract class Failure {
  final String message;
  Failure(this.message);
}
class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioException e){
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connectionTimeout  with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('sendTimeout with  api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receiveTimeout with  api server');
      case DioExceptionType.badCertificate:
        return ServerFailure('connectionTimeout  with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.badResponseError(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('please try again');
    }
  }

  factory ServerFailure.badResponseError(int statuesCode, dynamic response){
    if (statuesCode == 400) {
      return ServerFailure(' your request was not found ,please try later');
    } else if (statuesCode == 500) {
      return ServerFailure(' There is a problem server ,please try later');
    } else if (statuesCode == 400 || statuesCode == 401 || statuesCode == 402|| statuesCode == 403|| statuesCode == 404 || statuesCode == 422) {
      return ServerFailure(response['message']);
    } else {
      return ServerFailure('There was an error ,please tray again');
    }
  }

}