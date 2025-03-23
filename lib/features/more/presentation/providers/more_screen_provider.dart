import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/models/more_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/usecases/more_usecase.dart';

final moreScreenProvider = StateNotifierProvider<MoreNotifier, MoreState>(
  (ref) => MoreNotifier(
    moreUseCase: sl(),
  ),
);

class MoreNotifier extends StateNotifier<MoreState> {
  final MoreUseCase _moreUseCase;

  MoreNotifier({
    required MoreUseCase moreUseCase,
  })  : _moreUseCase = moreUseCase,
        super(MoreState.initial());

  void getData() async {
    final results = await _moreUseCase();

    results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = MoreState(isLoading: false, message: failure.message);
      },
      (response) {
        state = MoreState(isLoading: false, moreModel: response);
      },
    );
  }
}

class MoreState {
  final bool isLoading;
  final String? message;
  final MoreModel? moreModel;

  MoreState({
    required this.isLoading,
    this.message,
    this.moreModel,
  });

  MoreState copyWith({
    bool? isLoading,
    String? message,
    MoreModel? moreModel,
  }) {
    return MoreState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      moreModel: moreModel ?? this.moreModel,
    );
  }

  factory MoreState.initial() {
    return MoreState(
      isLoading: false,
      message: '',
      moreModel: null,
    );
  }
}
