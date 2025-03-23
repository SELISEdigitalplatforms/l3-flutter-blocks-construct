import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/constants/core_constants.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/presentation/providers/login_provider.dart';

final biometricAuthProvider = StateNotifierProvider<BiometricAuthNotifier, bool>(
      (ref) => BiometricAuthNotifier(
    ref: ref,
    secureStorage: sl<FlutterSecureStorage>(),
  ),
);

class BiometricAuthNotifier extends StateNotifier<bool> {
  final Ref ref;
  final FlutterSecureStorage secureStorage;
  final LocalAuthentication auth = LocalAuthentication();

  final passwordForm = FormGroup({
    'password': FormControl<String>(validators: [Validators.required]),
  });

  BiometricAuthNotifier({
    required this.ref,
    required this.secureStorage,
  }) : super(false) {
    initializeBiometricState();
  }

  Future<void> initializeBiometricState() async {
    final enabled = await secureStorage.read(key: CoreConstants.biometricEnabled) ?? 'false';
    state = enabled == 'true';
  }

  void setBiometricEnabled(bool enabled) {
    state = enabled;
  }

  Future<void> enableBiometricAuth({required String email}) async {
    bool canAuthenticate = await auth.canCheckBiometrics || await auth.isDeviceSupported();
    if (!canAuthenticate) return;

    bool didAuthenticate = await auth.authenticate(
      localizedReason: 'Please authenticate to login',
      options: const AuthenticationOptions(biometricOnly: true),
    );

    if (!didAuthenticate) return;

    final passwordControl = passwordForm.control('password');
    final String? password = passwordControl.value;
    if (password == null || email.isEmpty) return;

    try {
      final loginSuccess = await ref.read(loginProvider.notifier).login(email, password);

      if (!loginSuccess) {
        throw Exception("Login failed");
      }

      // Clearing any existing error messages
      passwordControl.removeError('invalidCredentials');

      await secureStorage.write(key: CoreConstants.biometricEmail, value: email);
      await secureStorage.write(key: CoreConstants.biometricPassword, value: password);
      await secureStorage.write(key: CoreConstants.biometricEnabled, value: 'true');

      setBiometricEnabled(true);
    } catch (error) {
      passwordControl.markAsTouched();
      passwordControl.setErrors({'invalidCredentials': "Wrong Password"});
      setBiometricEnabled(false);
    }
  }

  Future<void> disableBiometricAuth() async {
    await secureStorage.write(key: CoreConstants.biometricEnabled, value: 'false');
    await secureStorage.delete(key: CoreConstants.biometricEmail);
    await secureStorage.delete(key: CoreConstants.biometricPassword);

    setBiometricEnabled(false);
  }
}
