import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

abstract class BaseException implements Exception {
  abstract final String? message;
}

class CommonUiException implements BaseException {
  const CommonUiException({this.message});

  @override
  final String? message;
}

class InternetConnectionException implements BaseException {
  const InternetConnectionException({this.message});

  @override
  final String? message;
}
