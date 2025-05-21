import 'package:l3_flutter_selise_blocksconstruct/core/usecase/usecase.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/dashboard/domain/models/dashboard_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/dashboard/domain/repos/dashboard_repo.dart';

class DashboardUseCase extends UseCaseWithoutParams<DashboardModel> {
  const DashboardUseCase(this._repo);

  final DashboardRepo _repo;

  @override
  ResultFuture<DashboardModel> call() => _repo.getData();
}
