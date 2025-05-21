GenericResponseModel genericResponseModelModelFromJson(
        Map<String, dynamic> json) =>
    GenericResponseModel.fromJson(json);

class GenericResponseModel {
  String status;
  String message;

  GenericResponseModel({
    required this.status,
    required this.message,
  });

  GenericResponseModel copyWith({
    String? status,
    String? message,
    String? data,
  }) =>
      GenericResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory GenericResponseModel.initialData() {
    return GenericResponseModel(
      status: '',
      message: '',
    );
  }

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) =>
      GenericResponseModel(
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };

  @override
  String toString() =>
      'GenericResponseModel(status: $status, message: $message)';
}
