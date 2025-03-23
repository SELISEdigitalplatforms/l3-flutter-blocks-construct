import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';

class ResetPasswordUseCase extends UseCaseWithParams<RecoverModel, ResetPasswordParams> {
  const ResetPasswordUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<RecoverModel> call(ResetPasswordParams params) => _repo.resetPasswordRepo(params.password, params.code);
}
