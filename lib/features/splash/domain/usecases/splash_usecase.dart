import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/models/splash_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/splash/domain/repos/splash_repo.dart';

class SplashUseCase extends UseCaseWithoutParams<SplashModel> {
  const SplashUseCase(this._repo);

  final SplashRepo _repo;

  @override
  ResultFuture<SplashModel> call() => _repo.getData();
}
