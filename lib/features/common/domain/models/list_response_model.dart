class ListModelResponse<T> {
  final String status;
  final String message;
  final List<T> data;

  ListModelResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  ListModelResponse<T> copyWith({
    String? status,
    String? message,
    List<T>? data,
  }) =>
      ListModelResponse<T>(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ListModelResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
    ) {
    final dynamic rawData = json['data'];

    return ListModelResponse<T>(
      status: json['status'],
      message: json['message'],
      data: List<T>.from(rawData.map((x) => fromJsonT(x))),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) => {
        'status': status,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => toJsonT(x))),
      };
}
