import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/models/iam_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/usecases/iam_usecase.dart';

final iamScreenProvider = StateNotifierProvider<IamNotifier, IamState>(
  (ref) => IamNotifier(
    iamUseCase: sl(),
  ),
);

class IamNotifier extends StateNotifier<IamState> {
  final IamUseCase _iamUseCase;

  IamNotifier({
    required IamUseCase iamUseCase,
  })  : _iamUseCase = iamUseCase,
        super(IamState.initial());

  void getData() async {
    final results = await _iamUseCase();

    results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = IamState(isLoading: false, message: failure.message);
      },
      (response) {
        state = IamState(isLoading: false, iamModel: response);
      },
    );
  }
}

class IamState {
  final bool isLoading;
  final String? message;
  final IamModel? iamModel;

  IamState({
    required this.isLoading,
    this.message,
    this.iamModel,
  });

  IamState copyWith({
    bool? isLoading,
    String? message,
    IamModel? iamModel,
  }) {
    return IamState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      iamModel: iamModel ?? this.iamModel,
    );
  }

  factory IamState.initial() {
    return IamState(
      isLoading: false,
      message: '',
      iamModel: null,
    );
  }
}
