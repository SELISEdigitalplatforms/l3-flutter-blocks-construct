import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/token_model.dart';

typedef AuthModel = TokenModel;

class LoginParams {
  String username;
  String password;

  LoginParams({
    required this.username,
    required this.password,
  });
}

class ForgotPasswordParams {
  String username;

  ForgotPasswordParams({
    required this.username,
  });
}

class ResetPasswordParams {
  String password;
  String code;

  ResetPasswordParams({
    required this.password,
    required this.code,
  });
}
