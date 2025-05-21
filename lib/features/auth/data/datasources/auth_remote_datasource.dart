import 'package:dio/dio.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> loginDIO(String email, String password);
  Future<LogoutModel> logout();
  Future<RecoverModel> forgotPasswordDIO(String email);
  Future<RecoverModel> resetPasswordDIO(String password, String code);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this.authService);

  final IAuthService authService;

  @override
  Future<AuthModel> loginDIO(String username, String password) async {
    try {
      return await authService.login(username, password);
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      rethrow;
      // throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<LogoutModel> logout() async {
    try {
      return await authService.logout();
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<RecoverModel> forgotPasswordDIO(String username) async {
    try {
      return await authService.forgotPassword(username);
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<RecoverModel> resetPasswordDIO(String password, String code) async {
    try {
      return await authService.resetPassword(password, code);
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }
}
