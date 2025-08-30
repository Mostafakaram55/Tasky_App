import 'package:dio/dio.dart';
import '../utils/app_constants.dart';
import 'app_interceptors.dart';
import 'end_pionts.dart';

class ApiService {
  late final Dio dio;
  ApiInterceptor apiInterceptor;
  ApiService(this.apiInterceptor){
    BaseOptions options=BaseOptions(

        baseUrl: EndPoints.baseUrlEndpoint,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type":'application/json',
          'Authorization':'Bearer ${AppConstants.accessToken}',
          'Accept':'application/json',
        });
    dio=Dio(options);
    dio.interceptors.add(apiInterceptor);
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestHeader: true,
      error: true,
      requestBody: true,
      responseHeader: true,
    ));
  }
  Future<Map<String,dynamic>> delete(
      String endPoint,
      {
        dynamic data,
        Map<String, dynamic>? queryParm,
        bool formData=false
      })async{
    final response= await dio.delete(
        endPoint,
        data:formData?FormData.fromMap(data): data,
        queryParameters: queryParm
    );
    return response.data;
  }


  Future<Response> get(
      String endPoint,
      {dynamic data,
        Map<String, dynamic>? queryParm,
        bool formData=false
      })async{
    return await dio.get(
        endPoint,
        data:formData?FormData.fromMap(data): data,
        queryParameters: queryParm
    );

  }


  Future<Map<String,dynamic>> put(
      String endPoint,
      {dynamic data,
        Map<String, dynamic>? queryParm,
        bool formData=false
      })async{
    final response= await dio.put(
        endPoint,
        data:formData?FormData.fromMap(data): data,
        queryParameters: queryParm
    );
    return response.data;
  }


  Future<Response> post(
      String endPoint,
      {
        dynamic data,
        Map<String,dynamic>? queryParm,
        bool formData=false
      }) async{
    return await dio.post(
        endPoint,
        data:formData?FormData.fromMap(data): data,
        queryParameters: queryParm
    );

  }

}