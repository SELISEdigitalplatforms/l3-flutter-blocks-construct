import '../../../../core/utils/typedefs.dart';
import '../models/splash_model.dart';


abstract class SplashRepo {

  ResultFuture<SplashModel> getData();

}
