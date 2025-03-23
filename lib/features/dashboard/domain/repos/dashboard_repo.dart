import '../../../../core/utils/typedefs.dart';
import '../models/dashboard_model.dart';


abstract class DashboardRepo {

  ResultFuture<DashboardModel> getData();

}
