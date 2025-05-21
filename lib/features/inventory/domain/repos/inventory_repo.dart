import '../../../../core/utils/typedefs.dart';
import '../models/inventory_model.dart';

abstract class InventoryRepo {
  ResultFuture<InventoryModel> getData();
}
