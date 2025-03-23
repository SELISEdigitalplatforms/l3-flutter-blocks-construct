import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'jwt_token_model.g.dart';

@JsonSerializable()
class JwtTokenModel {
  final bool? isAuthenticated;

  JwtTokenModel({
    this.isAuthenticated,
  });

  factory JwtTokenModel.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenModelFromJson(json);

  factory JwtTokenModel.fromString(String jsonString) =>
      JwtTokenModel.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => _$JwtTokenModelToJson(this);

  @override
  String toString() {
    return json.encode(toJson());
  }
}
