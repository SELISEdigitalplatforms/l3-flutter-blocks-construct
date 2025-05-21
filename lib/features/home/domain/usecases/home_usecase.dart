import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/models/home_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/home/domain/repos/home_repo.dart';

class HomeUseCase extends UseCaseWithoutParams<HomeModel> {
  const HomeUseCase(this._repo);

  final HomeRepo _repo;

  @override
  ResultFuture<HomeModel> call() => _repo.getData();
}
