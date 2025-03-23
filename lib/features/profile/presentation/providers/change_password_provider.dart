import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/profile_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/profile/domain/usecases/change_password_usecase.dart';

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
  (ref) => ChangePasswordNotifier(
    changePasswordUseCase: sl(),
  ),
);

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordNotifier({
    required ChangePasswordUseCase changePasswordUseCase,
  })  : _changePasswordUseCase = changePasswordUseCase,
        super(ChangePasswordState.initial());

  Future<bool> changePassword(String newPassword, String oldPassword) async {
    state = state.copyWith(isLoading: true);

    final params = ChangePasswordParams(
        newPassword: newPassword, oldPassword: oldPassword);
    final results = await _changePasswordUseCase(params);

    return results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = state.copyWith(isLoading: false, message: failure.message);
        return false;
      },
      (response) {
        state = state.copyWith(
          isLoading: false,
          message: "Error while update password",
        );
        return true;
      },
    );
  }
}

class ChangePasswordState {
  final bool isLoading;
  final String? message;

  ChangePasswordState({
    required this.isLoading,
    this.message,
  });

  ChangePasswordState copyWith({
    bool? isLoading,
    String? message,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }

  factory ChangePasswordState.initial() {
    return ChangePasswordState(
      isLoading: false,
      message: '',
    );
  }
}
