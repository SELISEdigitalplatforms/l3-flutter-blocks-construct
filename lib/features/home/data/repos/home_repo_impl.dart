import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/data/datasources/home_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/models/home_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  const HomeRepoImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<HomeModel> getData() async {
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
