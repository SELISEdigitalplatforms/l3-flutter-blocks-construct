// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileResponseModel _$UpdateProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileResponseModel(
      errors: json['errors'],
      isSuccess: json['isSuccess'] as bool?,
      itemId: json['itemId'] as String?,
    );

Map<String, dynamic> _$UpdateProfileResponseModelToJson(
        UpdateProfileResponseModel instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'isSuccess': instance.isSuccess,
      'itemId': instance.itemId,
    };
