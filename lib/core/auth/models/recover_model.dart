import 'package:json_annotation/json_annotation.dart';

part 'recover_model.g.dart';

@JsonSerializable()
class RecoverModel {
  final bool? isSuccess;
  final dynamic errors;

  const RecoverModel({
    this.isSuccess,
    this.errors,
  });

  factory RecoverModel.fromJson(Map<String, dynamic> json) => _$RecoverModelFromJson(json);
}
