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
        return ServerFailure.fromDioResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('please try again');
    }
  }

  factory ServerFailure.fromDioResponse(int statsCode, dynamic response) {
    switch (statsCode) {
      case 401:
      case 402:
      case 403:
      case 422:
      case 404:
        return ServerFailure(response['message']);
      case 500:
        return ServerFailure('Internal server error, Please try later!');
      default:
        return ServerFailure('Opps there was an error, Please try again!');
    }
  }
}