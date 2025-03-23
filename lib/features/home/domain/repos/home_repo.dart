import '../../../../core/utils/typedefs.dart';
import '../models/home_model.dart';


abstract class HomeRepo {

  ResultFuture<HomeModel> getData();

}
