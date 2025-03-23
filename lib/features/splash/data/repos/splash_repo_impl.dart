import 'package:dartz/dartz.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/data/datasources/splash_remote_datasource.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/models/splash_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/repos/splash_repo.dart';

class SplashRepoImpl implements SplashRepo {
  const SplashRepoImpl(this._remoteDataSource);

  final SplashRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<SplashModel> getData() async {
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
