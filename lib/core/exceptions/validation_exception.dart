// lib/core/exceptions/validation_exception.dart

import 'app_exception.dart';

class ValidationException extends AppException {
  ValidationException({
    required String message,
  }) : super(
    message: message,
    prefix: 'Validation Error: ',
  );
}

class RequiredFieldException extends ValidationException {
  final String fieldName;

  RequiredFieldException({
    required this.fieldName,
  }) : super(message: '$fieldName is required');
}

class InvalidEmailException extends ValidationException {
  InvalidEmailException() : super(message: 'Invalid email format');
}

class InvalidPhoneException extends ValidationException {
  InvalidPhoneException() : super(message: 'Invalid phone number format');
}

class PasswordTooShortException extends ValidationException {
  PasswordTooShortException({
    int minLength = 8,
  }) : super(message: 'Password must be at least $minLength characters');
}

class InvalidDateException extends ValidationException {
  InvalidDateException() : super(message: 'Invalid date format');
}