// lib/core/exceptions/auth_exception.dart

import 'app_exception.dart';

class AuthException extends AppException {
  AuthException({
    required String message,
  }) : super(
    message: message,
    prefix: 'Authentication Error: ',
  );
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super(message: 'Invalid username or password');
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super(message: 'User not found');
}

class UserAlreadyExistsException extends AuthException {
  UserAlreadyExistsException() : super(message: 'User already exists');
}

class TokenExpiredException extends AuthException {
  TokenExpiredException() : super(message: 'Session expired. Please login again');
}

class InvalidTokenException extends AuthException {
  InvalidTokenException() : super(message: 'Invalid session token');
}

class AccountLockedException extends AuthException {
  AccountLockedException() : super(message: 'Account is locked. Please contact support');
}