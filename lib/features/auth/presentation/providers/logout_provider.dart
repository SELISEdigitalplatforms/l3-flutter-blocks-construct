import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/auth/models/logout_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/auth/domain/usecases/logout_usecase.dart';

final logoutProvider = StateNotifierProvider<LogoutNotifier, LogoutState>(
  (ref) => LogoutNotifier(
    logoutUseCase: sl(),
  ),
);

class LogoutNotifier extends StateNotifier<LogoutState> {
  final LogoutUseCase _logoutUseCase;

  LogoutNotifier({
    required LogoutUseCase logoutUseCase,
  })  : _logoutUseCase = logoutUseCase,
        super(LogoutState.initial());

  Future<bool> logout() async {
    state = state.copyWith(isLoading: true);

    final results = await _logoutUseCase();

    return results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = state.copyWith(isLoading: false, message: failure.message);
        return false;
      },
      (response) {
        state = state.copyWith(
            isLoading: false,
            logoutModel: response,
            message: "Logout successful");
        return true;
      },
    );
  }
}

class LogoutState {
  final bool isLoading;
  final String? message;
  final LogoutModel? logoutModel;

  LogoutState({
    required this.isLoading,
    this.message,
    this.logoutModel,
  });

  LogoutState copyWith({
    bool? isLoading,
    String? message,
    LogoutModel? logoutModel,
  }) {
    return LogoutState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      logoutModel: logoutModel ?? this.logoutModel,
    );
  }

  factory LogoutState.initial() {
    return LogoutState(
      isLoading: false,
      message: '',
    );
  }
}
