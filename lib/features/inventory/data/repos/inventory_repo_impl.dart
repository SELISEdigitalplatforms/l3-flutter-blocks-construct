import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/data/datasources/inventory_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/models/inventory_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/inventory/domain/repos/inventory_repo.dart';

class InventoryRepoImpl implements InventoryRepo {
  const InventoryRepoImpl(this._remoteDataSource);

  final InventoryRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<InventoryModel> getData() async {
    try {
      final result = await _remoteDataSource.getData();
      return Right(result);
    } on CustomException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }
}
