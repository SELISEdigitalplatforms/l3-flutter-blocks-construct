import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';

class LogoutUseCase extends UseCaseWithoutParams<LogoutModel> {
  const LogoutUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LogoutModel> call() => _repo.logoutRepo();
}
