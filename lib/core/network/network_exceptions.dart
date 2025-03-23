import 'package:dio/dio.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/logger/app_logging.dart';

/// An enum that holds names for our custom exceptions.
enum _ExceptionType {
  /// The exception for an expired bearer token.
  tokenExpiredException,

  /// The exception for a prematurely cancelled request.
  cancelException,

  /// The exception for a failed connection attempt.
  connectTimeoutException,

  /// The exception for failing to send a request.
  sendTimeoutException,

  /// The exception for failing to receive a response.
  receiveTimeoutException,
  badCertificateException,
  connectionErrorException,
  badResponseException,
  badRequestException,

  /// The exception for an incorrect parameter in a request/response.
  formatException,

  /// The exception for an unknown type of failure.
  unrecognizedException,

  /// The exception for an unknown exception from the api.
  apiException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  serializationException,
}

class CustomException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final _ExceptionType exceptionType;

  CustomException({
    this.code,
    int? statusCode,
    required this.message,
    this.exceptionType = _ExceptionType.apiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory CustomException.fromDioException(Exception error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return CustomException(
              exceptionType: _ExceptionType.cancelException,
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionTimeout:
            return CustomException(
              exceptionType: _ExceptionType.connectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Connection not established',
            );
          case DioExceptionType.sendTimeout:
            return CustomException(
              exceptionType: _ExceptionType.sendTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return CustomException(
              exceptionType: _ExceptionType.receiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioExceptionType.badCertificate:
            return CustomException(
              exceptionType: _ExceptionType.badCertificateException,
              statusCode: error.response?.statusCode,
              message: 'Bad certificate issue',
            );
          case DioExceptionType.connectionError:
            return CustomException(
              exceptionType: _ExceptionType.connectionErrorException,
              statusCode: error.response?.statusCode,
              message: 'Connection error',
            );
          case DioExceptionType.badResponse:
            if (error.response?.statusCode == 400) {
              return CustomException(
                exceptionType: _ExceptionType.badRequestException,
                statusCode: error.response?.statusCode,
                message: error.response?.data['message'] ?? 'Bad Request',
              );
            }

            if (error.response?.statusCode == 404) {
              return CustomException(
                exceptionType: _ExceptionType.badResponseException,
                statusCode: error.response?.statusCode,
                message: error.response?.data['message'] ?? 'Bad Response',
              );
            }

            return CustomException(
              exceptionType: _ExceptionType.badResponseException,
              statusCode: error.response?.statusCode,
              message: error.response?.data != null && error.response?.data['message'] != null
                  ? error.response?.data['message']
                  : 'Bad Response',
            );

          case DioExceptionType.unknown:
            if (error.response?.data['headers']['code'] == null) {
              return CustomException(
                exceptionType: _ExceptionType.unrecognizedException,
                statusCode: error.response?.statusCode,
                message: error.response?.statusMessage ?? 'Unknown',
              );
            }
            final name = error.response?.data['headers']['code'] as String;
            final message = error.response?.data['headers']['message'] as String;

            if (name == _ExceptionType.tokenExpiredException.name) {
              return CustomException(
                exceptionType: _ExceptionType.tokenExpiredException,
                code: name,
                statusCode: error.response?.statusCode,
                message: message,
              );
            }
            return CustomException(
              message: message,
              code: name,
              statusCode: error.response?.statusCode,
            );
        }
      } else {
        return CustomException(
          exceptionType: _ExceptionType.unrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return CustomException(
        exceptionType: _ExceptionType.formatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return CustomException(
        exceptionType: _ExceptionType.unrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }

  factory CustomException.fromParsingException(Exception error) {
    return CustomException(
      exceptionType: _ExceptionType.serializationException,
      message: 'Failed to parse network response to model or vice versa',
    );
  }

  factory CustomException.fromBlocksException(DioException error) {
    return CustomException(
      exceptionType: _ExceptionType.serializationException,
      message: error.response?.data?['error_description'] ??
          error.response?.data?['message'] ??
          error.message ??
          'Something went wrong',
    );
  }
}
