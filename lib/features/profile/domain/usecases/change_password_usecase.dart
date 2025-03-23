import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/basic_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/i_profile_repo.dart';

class ChangePasswordUseCase
    extends UseCaseWithParams<BasicResponseModel, ChangePasswordParams> {
  const ChangePasswordUseCase(this._repo);

  final IProfileRepo _repo;

  @override
  ResultFuture<BasicResponseModel> call(ChangePasswordParams params) =>
      _repo.changePassword(params.newPassword, params.oldPassword);
}
