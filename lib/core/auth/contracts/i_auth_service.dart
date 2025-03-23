import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/token_model.dart';

abstract class IAuthService {
  Future<TokenModel> login(
    String email,
    String password,
  );

  Future<LogoutModel> logout();

  Future<RecoverModel> forgotPassword(
    String email,
  );

  Future<String?> authRedirect(BuildContext context, GoRouterState state);

  Future<void> clearUserDetails();

  Future<RecoverModel> resetPassword(String password, String code);
}
