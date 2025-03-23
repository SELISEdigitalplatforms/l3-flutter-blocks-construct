import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/token_model.dart';

abstract class ITokenService {
  Future<String?> getAccessToken();

  Future<void> setAccessToken(String token);

  Future<String?> getRefreshToken();

  Future<void> setRefreshToken(token);

  Future<TokenModel> getAnonymousToken();

  Future<TokenModel> getAccessTokenByRefreshToken();

  Future<Map<String, String>> getSecurityHeaders();

  Future<void> clearToken();
}
