BasicResponseModel basicResponseModelModelFromJson(Map<String, dynamic> json) => BasicResponseModel.fromJson(json);

class BasicResponseModel {
  final bool isSuccess;
  final Map<String, dynamic>? errors;

  BasicResponseModel({
    required this.isSuccess,
    required this.errors,
  });

  BasicResponseModel copyWith({
    bool? isSuccess,
    Map<String, dynamic>? errors,
  }) =>
      BasicResponseModel(
        isSuccess: isSuccess ?? this.isSuccess,
        errors: errors ?? this.errors,
      );

  factory BasicResponseModel.initialData() {
    return BasicResponseModel(
      isSuccess: false,
      errors: null,
    );
  }

  factory BasicResponseModel.fromJson(Map<String, dynamic> json) => BasicResponseModel(
        isSuccess: json['isSuccess'],
        errors: json['errors'],
      );

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'errors': errors,
      };

  @override
  String toString() => 'BasicResponseModel(status: $isSuccess, message: $errors)';
}
