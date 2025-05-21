import 'package:dio/dio.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/models/network_exception_types.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor() : super();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey('requiresAuthToken')) {
      if (options.extra['requiresAuthToken'] == true) {
        final token = await sl<ITokenService>().getAccessToken();
        options.headers.addAll(
          <String, Object?>{
            CoreConstants.bearerTokenHeaderName: 'Bearer $token',
            ...await sl<ITokenService>().getSecurityHeaders(),
          },
        );
      }
      options.extra.remove('requiresAuthToken');
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    NetworkExceptionTypes errorType = NetworkExceptionTypes.other;
    try {
      final errorData = err.response?.data;
      final error =
          errorData == null || errorData == '' ? '' : errorData['error'];
      errorType = NetworkExceptionTypes.fromString(error);
    } catch (e) {
      logger.e(error: e, message: 'Error parsing error response');
    }
    if (err.response?.statusCode == 400) {
      switch (errorType) {
        case NetworkExceptionTypes.invalidRefreshToken:
          await sl<IAuthService>().clearUserDetails();
          break;
        case NetworkExceptionTypes.termAndConditionAcceptanceRequire:
        case NetworkExceptionTypes.twoFactorCodeRequire:
        case NetworkExceptionTypes.incorrectUserNameOrPassword:
        case NetworkExceptionTypes.sessionLockId:
        case NetworkExceptionTypes.personaRequire:
        case NetworkExceptionTypes.verificationCodeRequire:
        case NetworkExceptionTypes.invalidRequest:
        case NetworkExceptionTypes.siteIsNotRegistered:
        case NetworkExceptionTypes.invalidGrant:
        default:
          return handler.reject(err);
      }
    } else {
      return handler.next(err);
    }
    AppRouter.instance.navigation.replace(AppRoutes.login.path);
  }
}
