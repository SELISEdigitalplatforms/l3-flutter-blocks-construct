import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/models/inventory_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/repos/inventory_repo.dart';

class InventoryUseCase extends UseCaseWithoutParams<InventoryModel> {
  const InventoryUseCase(this._repo);

  final InventoryRepo _repo;

  @override
  ResultFuture<InventoryModel> call() => _repo.getData();
}
