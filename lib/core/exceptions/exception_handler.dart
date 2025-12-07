// lib/core/utils/exception_handler.dart

import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/exceptions/app_exception.dart';
import '../../core/exceptions/network_exception.dart';
import '../../core/exceptions/validation_exception.dart';

class ExceptionHandler {
  static AppException handle(dynamic error) {
    if (error is AppException) {
      return error;
    }

    if (error is http.ClientException) {
      return NetworkException(
        message: 'Network request failed: ${error.message}',
      );
    }

    if (error is SocketException) {
      return NetworkException(
        message: 'No internet connection',
      );
    }

    if (error is FormatException) {
      return ValidationException(
        message: 'Invalid data format: ${error.message}',
      );
    }

    if (error is TimeoutException) {
      return TimeoutException(
        message: 'Request timeout',
      );
    }

    // Handle other common exceptions
    if (error is IOException) {
      return NetworkException(
        message: 'IO Error occurred',
      );
    }

    // Default exception
    return AppException(
      message: error.toString(),
      prefix: 'Unknown Error: ',
    );
  }

  static String getErrorMessage(dynamic error) {
    final exception = handle(error);
    return exception.toString();
  }
}