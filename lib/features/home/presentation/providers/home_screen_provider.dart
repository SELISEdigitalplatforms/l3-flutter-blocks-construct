import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/models/home_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/usecases/home_usecase.dart';

final homeScreenProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(
    homeUseCase: sl(),
  ),
);

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeNotifier({
    required HomeUseCase homeUseCase,
  })  : _homeUseCase = homeUseCase,
        super(HomeState.initial());

  void getData() async {
    final results = await _homeUseCase();

    results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = HomeState(isLoading: false, message: failure.message);
      },
      (response) {
        state = HomeState(isLoading: false, homeModel: response);
      },
    );
  }
}

class HomeState {
  final bool isLoading;
  final String? message;
  final HomeModel? homeModel;

  HomeState({
    required this.isLoading,
    this.message,
    this.homeModel,
  });

  HomeState copyWith({
    bool? isLoading,
    String? message,
    HomeModel? homeModel,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      homeModel: homeModel ?? this.homeModel,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      message: '',
      homeModel: null,
    );
  }
}
