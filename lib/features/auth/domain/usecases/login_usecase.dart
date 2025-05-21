import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase extends UseCaseWithParams<AuthModel, LoginParams> {
  const LoginUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<AuthModel> call(LoginParams params) =>
      _repo.loginRepo(params.username, params.password);
}
