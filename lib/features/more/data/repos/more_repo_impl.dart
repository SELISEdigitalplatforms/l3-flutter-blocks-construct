import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/data/datasources/more_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/models/more_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/repos/more_repo.dart';

class MoreRepoImpl implements MoreRepo {
  const MoreRepoImpl(this._remoteDataSource);

  final MoreRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<MoreModel> getData() async {
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
