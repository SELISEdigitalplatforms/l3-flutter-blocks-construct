import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileModel {
  ProfileModel({
    this.data,
  });

  final Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  String toString() {
    return "{ data: $data }";
  }
}

@JsonSerializable()
class Data {
  Data({
    this.lastLoggedInTime,
    this.lastLoggedInDeviceInfo,
    this.logInCount,
    this.userMfaType,
    this.itemId,
    this.createdDate,
    this.lastUpdatedDate,
    this.language,
    this.salutation,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.roles,
    this.active,
    this.isVerified,
    this.profileImageUrl,
    this.mfaEnabled,
  });

  final DateTime? lastLoggedInTime;
  final String? lastLoggedInDeviceInfo;
  final int? logInCount;
  final int? userMfaType;
  final String? itemId;
  final DateTime? createdDate;
  final DateTime? lastUpdatedDate;
  final String? language;
  final String? salutation;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final List<String>? roles;
  final bool? active;
  @JsonKey(name: "isVarified")
  final bool? isVerified;
  final String? profileImageUrl;
  final bool? mfaEnabled;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() {
    return "{ lastLoggedInTime: $lastLoggedInTime, lastLoggedInDeviceInfo: $lastLoggedInDeviceInfo, logInCount: $logInCount, userMfaType: $userMfaType, itemId: $itemId, createdDate: $createdDate, lastUpdatedDate: $lastUpdatedDate, language: $language, salutation: $salutation, firstName: $firstName, lastName: $lastName, email: $email, userName: $userName, phoneNumber: $phoneNumber, roles: $roles, active: $active, isVerified: $isVerified, profileImageUrl: $profileImageUrl, mfaEnabled: $mfaEnabled }";
  }
}

class ChangePasswordParams {
  final String newPassword;
  final String oldPassword;

  ChangePasswordParams({
    required this.newPassword,
    required this.oldPassword,
  });
}
