import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this.authService);

  final IAuthService authService;

  @override
  ResultFuture<AuthModel> loginRepo(String username, String password) async {
    try {
      final result = await authService.login(username, password);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

  @override
  ResultFuture<LogoutModel> logoutRepo() async {
    try {
      final result = await authService.logout();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

  @override
  ResultFuture<RecoverModel> forgotPasswordRepo(String username) async {
    try {
      final result = await authService.forgotPassword(username);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

  @override
  ResultFuture<RecoverModel> resetPasswordRepo(String password, String code) async {
    try {
      final result = await authService.resetPassword(password, code);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }
}
