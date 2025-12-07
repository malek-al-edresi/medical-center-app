// lib/core/exceptions/cache_exception.dart

import 'app_exception.dart';

class CacheException extends AppException {
  CacheException({
    required String message,
  }) : super(
    message: message,
    prefix: 'Cache Error: ',
  );
}

class CacheWriteException extends CacheException {
  CacheWriteException({
    required String message,
  }) : super(message: message);
}

class CacheReadException extends CacheException {
  CacheReadException({
    required String message,
  }) : super(message: message);
}

class CacheDeleteException extends CacheException {
  CacheDeleteException({
    required String message,
  }) : super(message: message);
}