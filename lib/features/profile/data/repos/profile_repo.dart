import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/basic_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/repos/i_profile_repo.dart';

class ProfileRepo implements IProfileRepo {
  const ProfileRepo(this._remoteDataSource);

  final IProfileRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<ProfileModel> getData() async {
    try {
      final result = await _remoteDataSource.getData();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

  @override
  ResultFuture<BasicResponseModel> changePassword(
      String newPassword, String oldPassword) async {
    try {
      final result =
          await _remoteDataSource.changePassword(newPassword, oldPassword);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

  @override
  ResultFuture<UpdateProfileResponseModel> updateProfile(
      UpdateProfileModel updateProfileData) async {
    try {
      final result = await _remoteDataSource.updateProfile(updateProfileData);
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }
}
