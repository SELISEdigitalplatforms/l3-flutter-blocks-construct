class ObjectResponseModel<T> {
  final String status;
  final String message;
  final dynamic data; // Can be of type T or a List<T>

  ObjectResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  ObjectResponseModel<T> copyWith({
    String? status,
    String? message,
    dynamic data, // Keep dynamic for both T and List<T>
  }) =>
      ObjectResponseModel<T>(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ObjectResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dynamic rawData = json['data'];

    return ObjectResponseModel<T>(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(rawData),
    );
  }

  factory ObjectResponseModel.fromJsonForGeneric(
    Map<String, dynamic> json, {
    String? dataKey,
  }) {
    return ObjectResponseModel<T>(
      status: json['status'],
      message: json['message'],
    );
  }

  factory ObjectResponseModel.fromJsonWithParams(
    Map<String, dynamic> json,
    T Function(
      Map<String, dynamic>, {
      String? homeMatchTeamId,
      String? awayMatchTeamId,
      String? matchId,
    }) fromJsonT, {
    String? homeMatchTeamId,
    String? awayMatchTeamId,
    String? matchId,
    bool isArray = false, // New optional parameter to handle arrays
  }) {
    final dynamic rawData = json['data'];
    final dynamic contentData = rawData;

    return ObjectResponseModel<T>(
      status: json['status'],
      message: json['message'],
      data: isArray
          ? (contentData as List)
              .map((item) => fromJsonT(item,
                  homeMatchTeamId: homeMatchTeamId,
                  awayMatchTeamId: awayMatchTeamId,
                  matchId: matchId))
              .toList()
          : fromJsonT(contentData,
              homeMatchTeamId: homeMatchTeamId,
              awayMatchTeamId: awayMatchTeamId,
              matchId: matchId),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) => {
        'status': status,
        'message': message,
        'data': data is List
            ? (data as List).map((item) => toJsonT(item)).toList()
            : toJsonT(data),
      };
}
