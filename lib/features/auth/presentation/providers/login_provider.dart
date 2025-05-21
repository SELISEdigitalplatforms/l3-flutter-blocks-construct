import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    loginUseCase: sl(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final FlutterSecureStorage _secureStorage = sl<FlutterSecureStorage>();
  final LocalAuthentication _localAuth = LocalAuthentication();

  LoginNotifier({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(LoginState.initial());

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final params = LoginParams(username: email, password: password);
    final results = await _loginUseCase(params);

    return results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = state.copyWith(isLoading: false, message: failure.message);
        return false;
      },
      (response) {
        state = state.copyWith(isLoading: false, authModel: response, message: "Login successful");
        return true;
      },
    );
  }

  Future<bool> loginWithBiometrics() async {
    state = state.copyWith(isLoading: true);
    try {
      final biometricEnabled = await _secureStorage.read(key: CoreConstants.biometricEnabled);
      if (biometricEnabled != 'true') {
        state = state.copyWith(isLoading: false, message: 'Biometric login is not set up. Please log in normally and enable biometrics from your profile.');
        return false;
      }

      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (!didAuthenticate) {
        state = state.copyWith(isLoading: false, message: 'Biometric authentication failed.');
        return false;
      }

      final email = await _secureStorage.read(key: CoreConstants.biometricEmail) ?? '';
      final password = await _secureStorage.read(key: CoreConstants.biometricPassword) ?? '';
      if (email.isEmpty || password.isEmpty) {
        state = state.copyWith(isLoading: false, message: 'Saved credentials not found.');
        return false;
      }

      return await login(email, password);
    } catch (error) {
      state = state.copyWith(isLoading: false, message: error.toString());
      return false;
    }
  }
}

class LoginState {
  final bool isLoading;
  final String? message;
  final AuthModel? authModel;

  LoginState({
    required this.isLoading,
    this.message,
    this.authModel,
  });

  LoginState copyWith({
    bool? isLoading,
    String? message,
    AuthModel? authModel,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      authModel: authModel ?? this.authModel,
    );
  }

  factory LoginState.initial() {
    return LoginState(
      isLoading: false,
      message: '',
      authModel: AuthModel(),
    );
  }
}
