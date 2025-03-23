import 'package:json_annotation/json_annotation.dart';

part 'update_profile_model.g.dart';

@JsonSerializable()
class UpdateProfileModel {
  const UpdateProfileModel({
    this.email,
    this.firstName,
    this.itemId,
    this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
  });

  final String? email;
  final String? firstName;
  final String? itemId;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  Map<String, dynamic> toJson() => _$UpdateProfileModelToJson(this);
}
