// lib/core/exceptions/business_exception.dart

import 'app_exception.dart';

class BusinessException extends AppException {
  BusinessException({
    required String message,
  }) : super(
    message: message,
    prefix: 'Business Error: ',
  );
}

class InsufficientPermissionsException extends BusinessException {
  InsufficientPermissionsException()
      : super(message: 'Insufficient permissions to perform this action');
}

class ResourceNotFoundException extends BusinessException {
  ResourceNotFoundException({
    required String resource,
  }) : super(message: '$resource not found');
}

class DuplicateResourceException extends BusinessException {
  DuplicateResourceException({
    required String resource,
  }) : super(message: '$resource already exists');
}

class OperationNotAllowedException extends BusinessException {
  OperationNotAllowedException({
    required String operation,
  }) : super(message: '$operation is not allowed');
}

class QuotaExceededException extends BusinessException {
  QuotaExceededException({
    required String resource,
  }) : super(message: 'Quota exceeded for $resource');
}