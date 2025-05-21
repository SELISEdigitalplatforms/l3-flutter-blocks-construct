import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/forgot_password_usecase.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) => ForgotPasswordNotifier(
    forgotPasswordUseCase: sl(),
  ),
);

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordNotifier({
    required ForgotPasswordUseCase forgotPasswordUseCase,
  })  : _forgotPasswordUseCase = forgotPasswordUseCase,
        super(ForgotPasswordState.initial());

  Future<bool> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true);

    final params = ForgotPasswordParams(username: email);
    final results = await _forgotPasswordUseCase(params);

    return results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = state.copyWith(isLoading: false, message: failure.message);
        return false;
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          recoverModel: response,
          message: "Sent mail successful",
        );
        return true;
      },
    );
  }
}

class ForgotPasswordState {
  final bool isLoading;
  final String? message;
  final RecoverModel? recoverModel;

  ForgotPasswordState({
    required this.isLoading,
    this.message,
    this.recoverModel,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? message,
    RecoverModel? recoverModel,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      recoverModel: recoverModel ?? this.recoverModel,
    );
  }

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isLoading: false,
      message: '',
      recoverModel: RecoverModel(),
    );
  }
}
