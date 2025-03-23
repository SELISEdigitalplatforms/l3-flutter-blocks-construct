import 'package:l3_flutter_selise_blocksconstruct/core/utils/typedefs.dart';

class ResponseModel<T> {
  final T body;

  const ResponseModel({
    required this.body,
  });

  factory ResponseModel.fromJson(JSON json) {
    return ResponseModel(
      body: json as T,
    );
  }
}
