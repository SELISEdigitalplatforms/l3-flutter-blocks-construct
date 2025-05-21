import '../../../../core/utils/typedefs.dart';
import '../models/iam_model.dart';


abstract class IamRepo {

  ResultFuture<IamModel> getData();

}
