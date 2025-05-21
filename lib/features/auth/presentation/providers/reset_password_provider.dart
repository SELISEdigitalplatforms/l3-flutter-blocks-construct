import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/recover_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/models/auth_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/reset_password_usecase.dart';

final resetPasswordProvider = StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  (ref) => ResetPasswordNotifier(
    resetPasswordUseCase: sl(),
  ),
);

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordNotifier({
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _resetPasswordUseCase = resetPasswordUseCase,
        super(ResetPasswordState.initial());

  Future<bool> resetPassword(String password, String code) async {
    state = state.copyWith(isLoading: true);

    final params = ResetPasswordParams(password: password, code: code);
    final results = await _resetPasswordUseCase(params);

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
          message: "Password reset successfully",
        );
        return true;
      },
    );
  }
}

class ResetPasswordState {
  final bool isLoading;
  final String? message;
  final RecoverModel? recoverModel;

  ResetPasswordState({
    required this.isLoading,
    this.message,
    this.recoverModel,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    String? message,
    RecoverModel? recoverModel,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      recoverModel: recoverModel ?? this.recoverModel,
    );
  }

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      isLoading: false,
      message: '',
      recoverModel: RecoverModel(),
    );
  }
}
