import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/data/datasources/iam_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/models/iam_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/repos/iam_repo.dart';

class IamRepoImpl implements IamRepo {
  const IamRepoImpl(this._remoteDataSource);

  final IamRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<IamModel> getData() async {
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
