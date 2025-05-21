import 'package:dio/dio.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/api_endpoint.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/dio_service.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/network/network_exceptions.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/domain/models/object_response_model.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/iam/domain/models/iam_model.dart';

abstract class IamRemoteDataSource {
  Future<IamModel> getData();
}

class IamRemoteDataSourceImpl implements IamRemoteDataSource {
  const IamRemoteDataSourceImpl(this.dioService);

  final DioService dioService;

  @override
  Future<IamModel> getData() async {
    try {
      final response = await dioService.get<JSON>(
        endpoint: ApiEndpoint.test(TestEndpoint.test),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': true, //true or false
          },
        ),
      );

      return ObjectResponseModel.fromJson(response.body, IamModel.fromJson).data;
    } on DioException catch (ex) {
      throw CustomException.fromBlocksException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }
}
