// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoverModel _$RecoverModelFromJson(Map<String, dynamic> json) => RecoverModel(
      isSuccess: json['isSuccess'] as bool?,
      errors: json['errors'],
    );

Map<String, dynamic> _$RecoverModelToJson(RecoverModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'errors': instance.errors,
    };
