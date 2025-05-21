import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/models/more_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/more/domain/repos/more_repo.dart';

class MoreUseCase extends UseCaseWithoutParams<MoreModel> {
  const MoreUseCase(this._repo);

  final MoreRepo _repo;

  @override
  ResultFuture<MoreModel> call() => _repo.getData();
}
