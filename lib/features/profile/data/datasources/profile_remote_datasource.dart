import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/dio_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/basic_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/models/update_profile_response_model.dart';

abstract class IProfileRemoteDataSource {
  Future<ProfileModel> getData();

  Future<BasicResponseModel> changePassword(String newPassword, String oldPassword);

  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileModel updateProfileData);
}

class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl(this.dioService);

  final DioService dioService;

  @override
  Future<ProfileModel> getData() async {
    try {
      final response = await dioService.get<JSON>(
        endpoint: dotenv.get('PROFILE_URL'),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': true,
          },
        ),
      );
      return ProfileModel.fromJson(response.body);
    } on DioException catch (ex) {
      throw CustomException.fromBlocksException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<BasicResponseModel> changePassword(String newPassword, String oldPassword) async {
    try {
      final response = await dioService.post<JSON>(
        endpoint: dotenv.get('CHANGE_PASSWORD'),
        data: {
          "newPassword": newPassword,
          "oldPassword": oldPassword,
          "projectKey": dotenv.get('X_BLOCKS_KEY'),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Origin': dotenv.get('ORIGIN_URL'),
          },
          extra: <String, Object?>{
            'requiresAuthToken': true,
          },
        ),
      );

      return BasicResponseModel.fromJson(response.body);
    } on DioException catch (ex) {
      throw CustomException.fromBlocksException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileModel updateProfileData) async {
    try {
      final response = await dioService.post<JSON>(
        endpoint: dotenv.get('UPDATE_PROFILE'),
        data: updateProfileData.toJson(),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': true,
          },
        ),
      );
      return UpdateProfileResponseModel.fromJson(response.body);
    } on DioException catch (ex) {
      throw CustomException.fromBlocksException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }
}
