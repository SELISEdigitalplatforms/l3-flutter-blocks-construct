import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/repos/auth_repo.dart';

class ForgotPasswordUseCase
    extends UseCaseWithParams<RecoverModel, ForgotPasswordParams> {
  const ForgotPasswordUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<RecoverModel> call(ForgotPasswordParams params) =>
      _repo.forgotPasswordRepo(params.username);
}
