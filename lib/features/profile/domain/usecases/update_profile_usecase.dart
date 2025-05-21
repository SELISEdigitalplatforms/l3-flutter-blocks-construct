import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/i_profile_repo.dart';

class UpdateProfileUsecase
    extends UseCaseWithParams<UpdateProfileResponseModel, UpdateProfileModel> {
  const UpdateProfileUsecase(this._repo);

  final IProfileRepo _repo;

  @override
  ResultFuture<UpdateProfileResponseModel> call(
          UpdateProfileModel updateProfileData) =>
      _repo.updateProfile(updateProfileData);
}
