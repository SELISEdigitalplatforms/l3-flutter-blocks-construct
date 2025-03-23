import '../../../../core/utils/typedefs.dart';
import '../models/more_model.dart';


abstract class MoreRepo {

  ResultFuture<MoreModel> getData();

}
