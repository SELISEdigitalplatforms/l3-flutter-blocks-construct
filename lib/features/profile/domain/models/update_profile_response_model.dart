import 'package:json_annotation/json_annotation.dart';

part 'update_profile_response_model.g.dart';

@JsonSerializable()
class UpdateProfileResponseModel {
  const UpdateProfileResponseModel({
    this.errors,
    this.isSuccess,
    this.itemId,
  });

  final dynamic errors;
  final bool? isSuccess;
  final String? itemId;

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseModelFromJson(json);
}
