import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/contracts/i_token_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/grant_types.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/token_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/dio_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';

class BlocksTokenService implements ITokenService {
  final FlutterSecureStorage _secureStorage;
  final DioService _dioService;

  BlocksTokenService(this._secureStorage, this._dioService);

  @override
  Future<String?> getAccessToken() {
    try {
      return _secureStorage.read(key: CoreConstants.accessToken);
    } catch (exception) {
      throw const CacheException(
          message: 'Error getting access token from local storage');
    }
  }

  @override
  Future<void> setAccessToken(String token) {
    try {
      return _secureStorage.write(key: CoreConstants.accessToken, value: token);
    } catch (exception) {
      throw const CacheException(
        message: "Error setting refresh token from local storage",
      );
    }
  }

  @override
  Future<String?> getRefreshToken() {
    try {
      return _secureStorage.read(key: CoreConstants.refreshToken);
    } catch (exception) {
      throw const CacheException(
        message: "Error getting refresh token from local storage",
      );
    }
  }

  @override
  Future<void> setRefreshToken(token) {
    try {
      return _secureStorage.write(
          key: CoreConstants.refreshToken, value: token);
    } catch (exception) {
      throw const CacheException(
        message: "Error setting refresh token from local storage",
      );
    }
  }

  @override
  Future<TokenModel> getAnonymousToken() async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('LOGIN'),
        data: {
          'grant_type': GrantTypes.authenticateSite.value,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Origin': dotenv.get('ORIGIN_URL'),
            ...await getSecurityHeaders(),
          },
        ),
      );
      return TokenModel.fromJson(response.body);
    } on DioException catch (err) {
      throw ServerException(
        message: err.response?.data['error_description'] ?? 'Server Error',
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<TokenModel> getAccessTokenByRefreshToken() async {
    try {
      final response = await _dioService.post<JSON>(
        endpoint: dotenv.get('LOGIN'),
        data: {
          'grant_type': GrantTypes.refreshToken.value,
          'refresh_token': await getRefreshToken()
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Origin': dotenv.get('ORIGIN_URL'),
            ...await getSecurityHeaders(),
          },
        ),
      );
      final tokenData = TokenModel.fromJson(response.body);
      await setAccessToken(tokenData.accessToken!);
      return tokenData;
    } on DioException catch (err) {
      throw ServerException(
        message: err.response?.data['error_description'] ?? 'Server Error',
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<Map<String, String>> getSecurityHeaders() async {
    return await Future.value({
      'x-blocks-key': dotenv.get('X_BLOCKS_KEY'),
    });
  }

  @override
  Future<void> clearToken() {
    return Future.wait([
      _secureStorage.delete(key: CoreConstants.accessToken),
      _secureStorage.delete(key: CoreConstants.refreshToken),
    ]);
  }
}
