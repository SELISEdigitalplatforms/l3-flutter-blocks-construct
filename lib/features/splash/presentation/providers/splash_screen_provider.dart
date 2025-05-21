import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/models/splash_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/usecases/splash_usecase.dart';

final splashScreenProvider = StateNotifierProvider<SplashNotifier, SplashState>(
  (ref) => SplashNotifier(
    splashUseCase: sl(),
  ),
);

class SplashNotifier extends StateNotifier<SplashState> {
  final SplashUseCase _splashUseCase;

  SplashNotifier({
    required SplashUseCase splashUseCase,
  })  : _splashUseCase = splashUseCase,
        super(SplashState.initial());

  void getData() async {
    final results = await _splashUseCase();

    results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = SplashState(isLoading: false, message: failure.message);
      },
      (response) {
        state = SplashState(isLoading: false, splashModel: response);
      },
    );
  }
}

class SplashState {
  final bool isLoading;
  final String? message;
  final SplashModel? splashModel;

  SplashState({
    required this.isLoading,
    this.message,
    this.splashModel,
  });

  SplashState copyWith({
    bool? isLoading,
    String? message,
    SplashModel? splashModel,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      splashModel: splashModel ?? this.splashModel,
    );
  }

  factory SplashState.initial() {
    return SplashState(
      isLoading: false,
      message: '',
      splashModel: null,
    );
  }
}
