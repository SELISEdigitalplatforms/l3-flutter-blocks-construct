import 'package:dio/dio.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;

  RefreshTokenInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newIdToken =
            await sl<ITokenService>().getAccessTokenByRefreshToken();
        err.requestOptions.headers = {
          ...err.requestOptions.headers,
          CoreConstants.bearerTokenHeaderName:
              'Bearer ${newIdToken.accessToken}',
          ...await sl<ITokenService>().getSecurityHeaders(),
        };
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final cloneReq = await _dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(cloneReq);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.reject(err);
  }
}
