import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/models/iam_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/repos/iam_repo.dart';

class IamUseCase extends UseCaseWithoutParams<IamModel> {
  const IamUseCase(this._repo);

  final IamRepo _repo;

  @override
  ResultFuture<IamModel> call() => _repo.getData();
}
