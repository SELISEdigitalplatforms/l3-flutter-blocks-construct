// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lastLoggedInTime: json['lastLoggedInTime'] == null
          ? null
          : DateTime.parse(json['lastLoggedInTime'] as String),
      lastLoggedInDeviceInfo: json['lastLoggedInDeviceInfo'] as String?,
      logInCount: (json['logInCount'] as num?)?.toInt(),
      userMfaType: (json['userMfaType'] as num?)?.toInt(),
      itemId: json['itemId'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
      language: json['language'] as String?,
      salutation: json['salutation'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      active: json['active'] as bool?,
      isVerified: json['isVarified'] as bool?,
      profileImageUrl: json['profileImageUrl'] as String?,
      mfaEnabled: json['mfaEnabled'] as bool?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lastLoggedInTime': instance.lastLoggedInTime?.toIso8601String(),
      'lastLoggedInDeviceInfo': instance.lastLoggedInDeviceInfo,
      'logInCount': instance.logInCount,
      'userMfaType': instance.userMfaType,
      'itemId': instance.itemId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
      'language': instance.language,
      'salutation': instance.salutation,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'roles': instance.roles,
      'active': instance.active,
      'isVarified': instance.isVerified,
      'profileImageUrl': instance.profileImageUrl,
      'mfaEnabled': instance.mfaEnabled,
    };
