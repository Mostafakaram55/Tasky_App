
import 'package:dio/dio.dart';
import '../../config/local/cache_helper.dart';
import '../../config/routes/app_routes.dart';
import '../errors/failures.dart';
import '../utils/app_constants.dart';
import 'end_pionts.dart';
class ApiInterceptor extends Interceptor {
  final Dio dio;
  ApiInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler,) async {
    String? authToken = await CacheHelper.getData(key: 'access_token');
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      AppRouter.navigateTo(AppRouter.kSignInView);
    }
    if (err.response?.statusCode == 401 && err.response?.realUri !=
        Uri.parse(EndPoints.baseUrlEndpoint + EndPoints.singInEndpoint)) {
      String?accessToken = CacheHelper.getData(key: 'access_token');
      String?refreshToken = CacheHelper.getData(key: 'refresh_token');
      if (refreshToken != null && refreshToken.isNotEmpty) {
        dio.options.baseUrl = EndPoints.baseUrlEndpoint;
        await dio.get(
            EndPoints.refreshTokenEndpoint,
            queryParameters: {
              'token': refreshToken,
            }
        ).then((value){
          String newToken=value.data['access_token'];
          CacheHelper.saveData(key: 'access_token', value: newToken);
          AppConstants.accessToken=newToken;
        }
        );
        accessToken=await CacheHelper.getData(key: 'access_token');
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
      super.onError(err, handler);
    }
    final failure = ServerFailure.fromDioError(err);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: failure.message,
        type: err.type,
        response: err.response,
      ),
    );

  }
}