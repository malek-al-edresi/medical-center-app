import 'app_exception.dart';

class NetworkException extends AppException {
  NetworkException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Connection Error: ',
    url: url,
  );
}

class BadRequestException extends AppException {
  BadRequestException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Bad Request: ',
    url: url,
  );
}

class UnauthorizedException extends AppException {
  UnauthorizedException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Unauthorized: ',
    url: url,
  );
}

class ForbiddenException extends AppException {
  ForbiddenException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Forbidden: ',
    url: url,
  );
}

class NotFoundException extends AppException {
  NotFoundException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Not Found: ',
    url: url,
  );
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Internal Server Error: ',
    url: url,
  );
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Service Unavailable: ',
    url: url,
  );
}

class TimeoutException extends AppException {
  TimeoutException({
    required String message,
    String url = '',
  }) : super(
    message: message,
    prefix: 'Timeout Error: ',
    url: url,
  );
}