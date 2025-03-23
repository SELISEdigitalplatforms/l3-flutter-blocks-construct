import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/di/injection_container.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/models/inventory_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/usecases/inventory_usecase.dart';

final inventoryScreenProvider = StateNotifierProvider<InventoryNotifier, InventoryState>(
  (ref) => InventoryNotifier(
    inventoryUseCase: sl(),
  ),
);

class InventoryNotifier extends StateNotifier<InventoryState> {
  final InventoryUseCase _inventoryUseCase;

  InventoryNotifier({
    required InventoryUseCase inventoryUseCase,
  })  : _inventoryUseCase = inventoryUseCase,
        super(InventoryState.initial());

  void getData() async {
    final results = await _inventoryUseCase();

    results.fold(
      (failure) {
        debugPrint("Error: $failure");
        state = InventoryState(isLoading: false, message: failure.message);
      },
      (response) {
        state = InventoryState(isLoading: false, inventoryModel: response);
      },
    );
  }
}

class InventoryState {
  final bool isLoading;
  final String? message;
  final InventoryModel? inventoryModel;

  InventoryState({
    required this.isLoading,
    this.message,
    this.inventoryModel,
  });

  InventoryState copyWith({
    bool? isLoading,
    String? message,
    InventoryModel? inventoryModel,
  }) {
    return InventoryState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      inventoryModel: inventoryModel ?? this.inventoryModel,
    );
  }

  factory InventoryState.initial() {
    return InventoryState(
      isLoading: false,
      message: '',
      inventoryModel: null,
    );
  }
}
