import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_auth_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/domain/utils/utils.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/grant_types.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/jwt_token_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/token_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/dio_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/storage/i_local_storage_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';

class BlocksAuthService implements IAuthService {
  final ITokenService _tokenService;
  final DioService _dioService;
  final ILocalStorageService _localStorageService;

  BlocksAuthService(
    this._tokenService,
    this._dioService,
    this._localStorageService,
  );

  @override
  Future<TokenModel> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('LOGIN'),
        data: {
          'grant_type': GrantTypes.password.value,
          'username': email,
          'password': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Origin': dotenv.get('ORIGIN_URL')},
          extra: <String, Object?>{
            'requiresAuthToken': true,
          },
        ),
      );
      final tokenData = TokenModel.fromJson(response.body);
      await _saveUserDetails(tokenData);
      return tokenData;
    } on DioException catch (err) {
      throw CustomException.fromBlocksException(err);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }

  @override
  Future<LogoutModel> logout() async {
    try {
      await clearUserDetails();
      String? refreshToken = await _tokenService.getRefreshToken();
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('LOGOUT'),
        data: {'refreshToken': refreshToken},
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
      return LogoutModel.fromJson(response.body);
    } on DioException catch (err) {
      throw CustomException.fromBlocksException(err);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }

  @override
  Future<RecoverModel> forgotPassword(String email) async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('RECOVER'),
        data: {
          "email": email,
          "captchaCode": "",
          "mailPurpose": "RecoverAccount",
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
      return RecoverModel.fromJson(response.body);
    } on DioException catch (err) {
      throw CustomException.fromBlocksException(err);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }

  @override
  Future<String?> authRedirect(BuildContext context, GoRouterState state) async {
    final localValue = await _localStorageService.getData(CoreConstants.jwtDetails);
    if (localValue != null && localValue.isNotEmpty) {
      final userDetails = JwtTokenModel.fromString(localValue);
      final authStatus = userDetails.isAuthenticated ?? false;
      if (authStatus) {
        return null;
      }
    }
    return AppRoutes.login.path;
  }

  @override
  Future<void> clearUserDetails() async {
    try {
      await _tokenService.clearToken();
      await _localStorageService.remove(CoreConstants.jwtDetails);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }

  Future<void> _saveUserDetails(TokenModel tokenData) async {
    try {
      await _tokenService.setAccessToken(tokenData.accessToken!);
      await _tokenService.setRefreshToken(tokenData.refreshToken);
      final jwtData = JwtTokenModel.fromJson(Utils.decodeJwt(tokenData.accessToken!));
      await _localStorageService.setData(CoreConstants.jwtDetails, jwtData.toString());
    } on DioException catch (err) {
      throw CustomException.fromBlocksException(err);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }

  @override
  Future<RecoverModel> resetPassword(String password, String code) async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('RESET_PASSWORD'),
        data: {
          "password": password,
          "code": code,
          "logoutFromAllDevices": true,
          "ProjectKey": dotenv.get('X_BLOCKS_KEY'),
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
      return RecoverModel.fromJson(response.body);
    } on DioException catch (err) {
      throw CustomException.fromBlocksException(err);
    } on Exception catch (err) {
      throw CustomException.fromParsingException(err);
    }
  }
}
