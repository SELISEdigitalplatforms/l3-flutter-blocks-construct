import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/basic_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_response_model.dart';

abstract class IProfileRepo {
  ResultFuture<ProfileModel> getData();

  ResultFuture<BasicResponseModel> changePassword(
      String newPassword, String oldPassword);

  ResultFuture<UpdateProfileResponseModel> updateProfile(
      UpdateProfileModel updateProfileData);
}
