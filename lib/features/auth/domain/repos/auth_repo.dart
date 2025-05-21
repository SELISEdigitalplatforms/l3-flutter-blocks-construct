import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';

abstract class AuthRepo {
  ResultFuture<AuthModel> loginRepo(String username, String password);
  ResultFuture<LogoutModel> logoutRepo();
  ResultFuture<RecoverModel> forgotPasswordRepo(String username);
  ResultFuture<RecoverModel> resetPasswordRepo(String password, String code);
}
